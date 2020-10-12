//
//  ItunesContentViewModel.swift
//  ITunesSearchApp
//
//  Created by Harun on 26.12.2019.
//  Copyright © 2019 harun. All rights reserved.
//

import Foundation
import RxSwift

final class ItunesContentViewModel: BaseViewModel {
    private let service: APIServiceType = APIService()
    var searchItunesContents: [ItunesContentResult] = []
    
    var itunesContentCount: Int {
        return searchItunesContents.count
    }
    
    func getItunesContent(at index: Int) -> ItunesContentResult {
        return searchItunesContents[index]
    }
    
    func getItunesContentTableViewCellViewModel(with index: Int) -> ItunesContentTableViewCellViewModel {
        return ItunesContentTableViewCellViewModel(with: getItunesContent(at: index))
    }
    
    
    func getSearchContent(searchText: String) -> Single<ItunesContentResponse?> {
        return service.getSearchContent(searchText: searchText)
            .do(onSuccess: { [weak self] response in
                
                guard let `self` = self, let searchItunesContents = response?.results else { return }
                self.searchItunesContents = searchItunesContents
                
            })
    }
    
}


