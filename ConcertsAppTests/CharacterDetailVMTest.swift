//
//  CharacterDetailVMTest.swift
//  ConcertsAppTests
//
//  Created by Harun on 6.07.2021.
//  Copyright © 2021 harun. All rights reserved.
//

import XCTest
import RxSwift
import Alamofire
@testable import ConcertsApp

class CharacterDetailVMTest: BaseXCTestCase {
    // MARK: - Properties
    private var sut: CharacterDetailVM! = CharacterDetailVM()
    private var service: APIServiceMock! = APIServiceMock()
    private var comics: [Comics]?
    private let testCharacterId = 1011334
    
    // MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        sut = CharacterDetailVM(service: service)
    }
    
    override func tearDown() {
        sut = nil
        service = nil
        super.tearDown()
    }
    
    // MARK: - Get Detail Character success case
    func test_detailCharacter_success() {
        service.shouldFetchSuccess = true
        fetchCharacterDetail()
        XCTAssertFalse(sut.characterName.isEmpty)
        XCTAssertFalse(sut.imageUrl.isEmpty)
        XCTAssertNotNil(sut.description)
        XCTAssertFalse(sut.comicsCount > 0)
        for i in 0 ..< sut.comicsCount {
            let cellVM = sut.getComicsTableViewCellVM(at: i)
            XCTAssertFalse(cellVM.comicName.isEmpty)
        }
    }
    
    // MARK: - Get Detail Character failure case
    func test_detailCharacter_failure() {
        service.shouldFetchSuccess = false
        fetchCharacterDetail()
        XCTAssertTrue(sut.characterName.isEmpty)
        XCTAssertNil(sut.description)
        XCTAssert(sut.comicsCount == 0)
    }
    
    private func fetchCharacterDetail() {
        let completedExpectation = expectation(description: "GetCharacterDetail")
        service.getCharacters(id: testCharacterId, limit: nil)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] response in
                guard let self = self,
                      let character = response?.data.characters?.first else { return }
                self.sut.selectedCharacter = character
                completedExpectation.fulfill()
            }, onError: { _ in
                completedExpectation.fulfill()
            }).disposed(by: disposeBag ?? DisposeBag())
        waitForExpectations(timeout: timeout, handler: nil)
    }
}
