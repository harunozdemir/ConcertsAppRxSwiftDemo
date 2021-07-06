//
//  ComicsTableViewCellVM.swift
//  ConcertsApp
//
//  Created by Harun on 5.07.2021.
//  Copyright © 2021 harun. All rights reserved.
//

import Foundation

class ComicsTableViewCellVM: BaseViewModel {
    private(set) var comicName: String = String()
    
    init(comicName: String = String()) {
        self.comicName = comicName
    }
}
