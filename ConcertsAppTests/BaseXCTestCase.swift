//
//  BaseXCTestCase.swift
//  ConcertsAppTests
//
//  Created by Harun on 8.08.2021.
//  Copyright © 2021 harun. All rights reserved.
//

import XCTest
import RxSwift
@testable import ConcertsApp

class BaseXCTestCase: XCTestCase {
    var disposeBag: DisposeBag? = DisposeBag()
    let timeout = 10.0

    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        disposeBag = nil
        super.tearDown()
    }
}
