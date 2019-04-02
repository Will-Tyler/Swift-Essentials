//
//  CompletionTests.swift
//  EssentialsTests
//
//  Created by Will Tyler on 4/2/19.
//

import XCTest

class CompletionTests: XCTestCase {

    func testBasic() {
		var didComplete = false
		let completion = Completion({ (result: Result<Int, Error>) in
			didComplete = true
		})

		XCTAssertFalse(didComplete)

		completion(.success(5))

		XCTAssertTrue(didComplete)
    }

	func testExecuteOnce() {
		var didComplete = false
		let completion = Completion<Int, Error> { result in
			didComplete = true
		}

		XCTAssertFalse(didComplete)

		completion(.success(5))

		XCTAssertTrue(didComplete)

		didComplete = false
		completion(.success(6))

		XCTAssertFalse(didComplete)
	}

}
