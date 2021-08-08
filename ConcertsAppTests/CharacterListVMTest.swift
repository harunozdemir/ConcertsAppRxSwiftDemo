//
//  CharacterListVMTest.swift
//  ConcertsAppTests
//
//  Created by Harun on 6.07.2021.
//  Copyright © 2021 harun. All rights reserved.
//

import XCTest
import RxSwift
@testable import ConcertsApp

class CharacterListVMTest: BaseXCTestCase {
    // MARK: - Properties
    private var sut: CharacterListVM! = CharacterListVM()
    private var characters: [Character]?
    
    // MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        sut = CharacterListVM()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_getAllCharacters_success() {
        sut.getCharacters(limit: 20)
        XCTAssertFalse(sut.characterCount > 0)
        for i in 0 ..< sut.characterCount {
            let cellVM = sut.getCharactersTableViewCellVM(at: i)
            XCTAssertFalse(cellVM.imageUrl.isEmpty)
            XCTAssertFalse(cellVM.name.isEmpty)
        }
    }
    
    private func fetchCharacters() {
        let completedExpectation = expectation(description: "GetAllCharacters")
        sut.getCharacters(limit: 10)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] response in
                guard let self = self else { return }
                self.characters = response?.data.characters
                completedExpectation.fulfill()
            }, onError: { [weak self] error in
                completedExpectation.fulfill()
            }).disposed(by: disposeBag ?? DisposeBag())
        waitForExpectations(timeout: timeout, handler: nil)
    }
}
