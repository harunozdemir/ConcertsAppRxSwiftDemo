//
//  APIService.swift
//  ConcertsApp
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
    func getCharacters(id:Int?, limit: Int?) -> Single<CharactersResponse?>
    func getComics(with characterId: Int, modifiedSince: String?) -> Single<ComicsResponse?>
}

enum Endpoint {
    enum UserBundle: String {
        case characters = "characters"
        
        var url: URL? {
            return URL(string: baseUrl + "v1/public/" + self.rawValue)
        }
        
        func urlDetail(with detailId: String) -> URL {
            return URL(string: baseUrl + "v1/public/" + self.rawValue + "/\(detailId)")!
        }
    }
}

final class APIService: APIServiceType {
    
    private let manager = HTTPManager.shared
    private let encoding = JSONEncoding.default
    private var defaultRequestParameter: [String: AnyObject] = [:]
    
    init() {
        defaultRequestParameter["ts"] = ts as AnyObject
        defaultRequestParameter["apikey"] = publicKey as AnyObject
        defaultRequestParameter["hash"] = hash as AnyObject
    }
    
    func getCharacters(id: Int? = nil, limit: Int? = nil) -> Single<CharactersResponse?> {
        var url: URL?
        if let id = id {
            url = Endpoint.UserBundle.characters.urlDetail(with: "\(id)")
        } else {
            url = Endpoint.UserBundle.characters.url
            
        }
        var parameters: [String: AnyObject] = defaultRequestParameter
        if let limit = limit {
            parameters["limit"] = limit as AnyObject
        }
        
        guard let url = url else {
            return Single.error(APIError(message: ""))
        }
        return request(methodType: .get, url: url, parameters: parameters)
    }
    
    func getComics(with characterId: Int, modifiedSince: String? = nil) -> Single<ComicsResponse?> {
        var parameters: [String: AnyObject] = defaultRequestParameter
        if let modifiedSince =  modifiedSince {
            parameters["modifiedSince"] = modifiedSince as AnyObject
        }
        return request(methodType: .get, url: Endpoint.UserBundle.characters.urlDetail(with: "\(characterId)/comics"), parameters: parameters)
    }
    
    private func request<T: Codable>(methodType: HTTPMethod, url: URL, parameters: [String: AnyObject]? = nil) -> Single<T?> {
        
        var requestUrl = url
        if methodType == .get {
            var queryString = parameters?.queryString ?? ""
            queryString = queryString.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!
            if !queryString.isEmpty {
                queryString.removeLast()
                requestUrl = URL(string: "\(url.absoluteString)?\(queryString)")!
            }

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
                
//                let _ = try! JSONDecoder().decode(T.self, from: data)
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
