//
//  ItunesContentDetailViewModel.swift
//  ITunesSearchApp
//
//  Created by Harun on 12.10.2020.
//  Copyright © 2020 harun. All rights reserved.
//

import Foundation

final class ItunesContentDetailViewModel: BaseViewModel {
    private let service: APIServiceType = APIService()
    var selectedItunesContent: ItunesContentResult?
    
    init(selectedItunesContent: ItunesContentResult?) {
        self.selectedItunesContent = selectedItunesContent
    }
    
    
}
