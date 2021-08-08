//
//  CharacterListVM.swift
//  ConcertsApp
//
//  Created by Harun on 4.07.2021.
//  Copyright © 2021 harun. All rights reserved.
//

import Foundation
import RxSwift

final class CharacterListVM: BaseViewModel {
    // MARK: - Properties:
    private var service: APIServiceType = APIService()
    var characters: [Character]
    
    init(characters: [Character] = [], service: APIServiceType = APIService()) {
        self.characters = characters
        self.service = service
    }
    
    func getCharacters(limit: Int) -> Single<CharactersResponse?> {
        return service.getCharacters(id: nil, limit: limit)
            .do(onSuccess: { [weak self] response in
                guard let self = self, let characters = response?.data.characters else { return }
                self.characters = characters
            })
    }
    
    func getCharactersTableViewCellVM(at index: Int) -> CharactersTableViewCellVM {
        guard index < self.characters.count else { return CharactersTableViewCellVM() }
        let character = self.characters[index]
        return CharactersTableViewCellVM(characterName: character.name, thumbnail: character.thumbnail)
    }
    
    // MARK: - Computed Properties:
    var characterCount: Int {
        characters.count
    }
    
    var allCharacters: [Character] {
        characters
    }
    
    func getCharacter(at index: Int) -> Character? {
        return index < characters.count ? characters[index] : nil
    }
}
