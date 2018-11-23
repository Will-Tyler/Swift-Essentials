//
//  ArrayTests.swift
//  EssentialsTests
//
//  Created by Will Tyler on 11/23/18.
//

import XCTest


class ArrayTests: XCTestCase {

	func testReplace() {
		var array = [Int](1...10)

		array.replace(at: 0, with: 11)
		array.replace(at: 4, with: 12)
		array.replace(at: 9, with: 100)

		XCTAssertEqual(array[0], 11)
		XCTAssertEqual(array[4], 12)
		XCTAssertEqual(array.last!, 100)
	}

}
