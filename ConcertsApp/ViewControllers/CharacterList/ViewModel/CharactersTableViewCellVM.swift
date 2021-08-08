//
//  CharactersTableViewCellVM.swift
//  ConcertsApp
//
//  Created by Harun on 5.07.2021.
//  Copyright © 2021 harun. All rights reserved.
//

import Foundation

class CharactersTableViewCellVM: BaseViewModel {
    // MARK: - Properties:
    private var characterName: String = String()
    private var thumbnail: Thumbnail?
    
    init(characterName: String = String(), thumbnail: Thumbnail? = nil) {
        self.characterName = characterName
        self.thumbnail = thumbnail
    }
    
    // MARK: - Computed Properties:
    var name: String {
        characterName
    }
    
    var imageUrl: String {
        (thumbnail?.path ?? "") + "." + (thumbnail?.thumbnailExtension ?? "")
    }
}
