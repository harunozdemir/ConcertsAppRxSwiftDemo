//
//  CharacterDetailVMTest.swift
//  ConcertsAppTests
//
//  Created by Harun on 6.07.2021.
//  Copyright © 2021 harun. All rights reserved.
//

import XCTest
import RxSwift
@testable import ConcertsApp

class CharacterDetailVMTest: XCTestCase {
    // MARK: - Properties
    private var sut: CharacterDetailVM! = CharacterDetailVM()
    private var character: Character?
    private var comics: [Comics]?
    
    // MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        sut = CharacterDetailVM()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_detailCharacter_success() {
        sut.id = 1011334
        fetchCharacterDetail()
        XCTAssertFalse(sut.characterName.isEmpty)
        XCTAssertFalse(sut.imageUrl.isEmpty)
        XCTAssertFalse(sut.description.isEmpty)
        XCTAssertFalse(sut.comicsCount > 0)
        for i in 0 ..< sut.comicsCount {
            let cellVM = sut.getComicsTableViewCellVM(at: i)
            XCTAssertFalse(cellVM.comicName.isEmpty)
        }
    }
    
    func test_getCharacterComics_success() {
        sut.id = 1011334
        fetchCharacterDetail()
        XCTAssertFalse(sut.characterComics.isEmpty)
        XCTAssertTrue(sut.comicsCount > 0)
    }
    
    private func fetchCharacterDetail() {
        let completedExpectation = expectation(description: "GetCharacterDetail")
        sut.getCharacter()
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] response in
                guard let self = self,
                      let character = response?.data.characters?.first else { return }
                self.character = character
                self.sut.selectedCharacter = character
                completedExpectation.fulfill()
            }, onError: { [weak self] error in
                completedExpectation.fulfill()
            }).disposed(by: DisposeBag())
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    private func fetchComics() {
        let completedExpectation = expectation(description: "GetComics")
        sut.getComics()
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] response in
                guard let self = self,
                      let comics = response?.data.comics
                else { return }
                self.comics = comics
                completedExpectation.fulfill()
            }, onError: { [weak self] error in
                completedExpectation.fulfill()
            }).disposed(by: DisposeBag())
        waitForExpectations(timeout: timeout, handler: nil)
    }
}
