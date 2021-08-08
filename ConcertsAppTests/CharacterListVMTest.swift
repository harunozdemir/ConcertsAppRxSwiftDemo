//
//  CharacterListVMTest.swift
//  ConcertsAppTests
//
//  Created by Harun on 6.07.2021.
//  Copyright © 2021 harun. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
@testable import ConcertsApp

class CharacterListVMTest: BaseXCTestCase {
    // MARK: - Properties
    private var sut: CharacterListVM! = CharacterListVM()
    private var service: APIServiceMock! = APIServiceMock()
    private var characters: [Character]?
    private let testScheduler = TestScheduler(initialClock: 0)
    
    // MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        sut = CharacterListVM(service: service)
    }
    
    override func tearDown() {
        sut = nil
        service = nil
        super.tearDown()
    }
    
    // MARK: - Get All Characters success case
    func test_getAllCharacters_success() {
        service.shouldFetchSuccess = true
        fetchCharacters()
        XCTAssertTrue(sut.characterCount > 0)
        for i in 0 ..< sut.characterCount {
            let cellVM = sut.getCharactersTableViewCellVM(at: i)
            XCTAssertFalse(cellVM.imageUrl.isEmpty)
            XCTAssertFalse(cellVM.name.isEmpty)
        }
    }
    
    // MARK: - Get All Characters failure case
    func test_getAllCharacters_failure() {
        service.shouldFetchSuccess = false
        fetchCharacters()
        XCTAssert(sut.characterCount == 0)
    }
    
    private func fetchCharacters() {
        let completedExpectation = expectation(description: "GetAllCharacters")
        service.getCharacters(id: nil, limit: 10)
            .observeOn(MainScheduler.instance)
            .subscribeOn(testScheduler)
            .subscribe(onSuccess: { [weak self] response in
                guard let self = self else { return }
                self.sut.characters = response?.data.characters ?? []
                completedExpectation.fulfill()
            }, onError: { _ in
                completedExpectation.fulfill()
            }).disposed(by: disposeBag ?? DisposeBag())
        testScheduler.start()
        waitForExpectations(timeout: timeout, handler: nil)
    }
}
