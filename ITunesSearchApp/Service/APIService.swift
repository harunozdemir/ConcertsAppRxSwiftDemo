//
//  APIService.swift
//  ITunesSearchApp
//
//  Created by Harun on 27.12.2019.
//  Copyright © 2019 harun. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire

extension Reactive where Base: SessionManager {
    func encodeMultipartUpload(to url: URLConvertible, method: HTTPMethod = .post, headers: HTTPHeaders = [:], data: @escaping (MultipartFormData) -> Void) -> Observable<UploadRequest> {
        return Observable.create { observer in
            self.base.upload(multipartFormData: data,
                             to: url,
                             method: method,
                             headers: headers,
                             encodingCompletion: { (result: SessionManager.MultipartFormDataEncodingResult) in
                                switch result {
                                case .failure(let error):
                                    observer.onError(error)
                                case .success(let request, let response, _):
                                    observer.onNext(request)
                                    observer.onCompleted()
                                }
            })
            return Disposables.create()
        }
    }
}

protocol APIServiceType {
    func getSearchContent(searchText: String) -> Single<ItunesContentResponse?>
}

enum Endpoint {
    enum UserBundle: String {
        case search = "search"
        
        var url: URL {
            return URL(string: BASE_URL + self.rawValue)!
        }
    }
}

final class APIService: APIServiceType {
    
    private let manager = HTTPManager.shared
    private let encoding = JSONEncoding.default
    //private var headers: [String: String] = ["Content-Type": "application/json", "api": Config.arnecaApiKey]
    
    init() {
        
    }
    
    func getSearchContent(searchText: String) -> Single<ItunesContentResponse?> {
        let parameters: [String:AnyObject] = ["term" : searchText as AnyObject]
        
        return request(methodType: .get, url: Endpoint.UserBundle.search.url, parameters: parameters)
    }
    
    private func request<T: Codable>(methodType: HTTPMethod, url: URL, parameters: [String: AnyObject]? = nil) -> Single<T?> {
        
        var requestUrl = url
        if methodType == .get {
            var queryString = parameters?.queryString ?? ""
            queryString = queryString.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!
            if !queryString.isEmpty {
                queryString.removeLast()
            }
            
            requestUrl = URL(string: "\(url.absoluteString)?\(queryString)")!
        }
        return manager.rx.responseString(methodType, requestUrl, parameters: methodType == .get ? nil : parameters, encoding: encoding)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1)))
            .asSingle()
            .catchError { error -> Single<(HTTPURLResponse, String)> in
                
                return Single.error(error)
        }
        .flatMap { json -> Single<T?> in
            let statusCode = json.0.statusCode
            let jsonString = json.1
            
            guard let data = jsonString.data(using: .utf8) else { return Single.just(nil) }
            
            let response = try! JSONDecoder().decode(T.self, from: data)
            if let response = try? JSONDecoder().decode(T.self, from: data) {
                return Single.just(response)
            }
            
            return Single.error(APIError(message: ""))
            
        }
    }
    
    final class HTTPManager: Alamofire.SessionManager {
        static let shared: HTTPManager = {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 140
            configuration.timeoutIntervalForResource = 140
            
            let manager = HTTPManager(configuration: configuration)
            return manager
        }()
    }
    
    final class APIError: Error {
        let message: String
        
        init(message: String) {
            self.message = message
            
        }
    }
    
    
}





