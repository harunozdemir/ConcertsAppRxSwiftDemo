//
//  CharacterDetailVM.swift
//  ConcertsApp
//
//  Created by Harun on 5.07.2021.
//  Copyright © 2021 harun. All rights reserved.
//

import Foundation
import RxSwift
final class CharacterDetailVM: BaseViewModel {
    private let service: APIServiceType = APIService()
    var id: Int
    var selectedCharacter: Character?
    private var comics: [Comics]?
    private let modifiedSince = "2015.01.01"
    
    init(id: Int = -1) {
        self.id = id
    }
    
    func getCharacter() -> Single<CharactersResponse?> {
        return service.getCharacters(id: id, limit: nil)
            .do(onSuccess: { [weak self] response in
                guard let self = self,
                      let characters = response?.data.characters,
                      !characters.isEmpty else { return }
                self.selectedCharacter = characters.first
            })
    }
    
    func getComics() -> Single<ComicsResponse?> {
        return service.getComics(with: id, modifiedSince: modifiedSince)
            .do(onSuccess: { [weak self] response in
                guard let self = self,
                      let comics = response?.data.comics,
                      !comics.isEmpty else { return }
                self.comics = comics
            })
    }
    
    // MARK: - Computed Properties
    var character: Character {
        selectedCharacter ?? Character()
    }
    
    var characterName: String {
        selectedCharacter?.name ?? ""
    }
    
    var imageUrl: String {
        (selectedCharacter?.thumbnail.path ?? "") + "." + (selectedCharacter?.thumbnail.thumbnailExtension ?? "")
    }
    
    var description: String {
        selectedCharacter?.description ?? ""
    }
    
    var characterComics: [Comics] {
        comics?.suffix(10) ?? []
    }
    
    var comicsCount: Int {
        characterComics.count
    }
    
    func getComicsItem(at index: Int) -> Comics {
        guard index < characterComics.count else { return Comics() }
        return characterComics[index]
    }
    
    func getComicsTableViewCellVM(at index: Int) -> ComicsTableViewCellVM {
        return ComicsTableViewCellVM(comicName: getComicsItem(at: index).title)
    }
}


