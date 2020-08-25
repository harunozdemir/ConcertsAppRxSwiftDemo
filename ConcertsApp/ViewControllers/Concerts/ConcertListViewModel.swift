//
//  ConcertListViewModel.swift
//  ConcertsApp
//
//  Created by Harun on 26.12.2019.
//  Copyright © 2019 harun. All rights reserved.
//

import Foundation
import RxSwift

final class ConcertListViewModel: BaseViewModel {
  private let service: APIServiceType = APIService()
  var concerts: [Concert] = []
  
  var concertCount: Int {
    return concerts.count
  }
  
  func getConcert(at index: Int) -> Concert {
    return concerts[index]
  }
  
  func getConcertTableViewCellViewModel(with index: Int) -> ConcertListItemTableViewCellViewModel {
    return ConcertListItemTableViewCellViewModel(with: getConcert(at: index))
  }
  
  
  func getConcerts() -> Single<ConcertResponse?> {
    return service.getConcerts()
      .do(onSuccess: { [weak self] response in
        
        guard let `self` = self, let concerts = response?.concerts else { return }
        self.concerts = concerts
        
      })
  }
  
}


