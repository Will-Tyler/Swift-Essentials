//
//  UnsafePointerTests.swift
//  EssentialsTests
//
//  Created by Will Tyler on 11/23/18.
//

import XCTest


class UnsafePointerTests: XCTestCase {

	func testAsterisk() {
		var array = [Int](1...10)
		var pointer = UnsafePointer(array)

		XCTAssertEqual(1, *pointer)

		array = [Int](100...109)
		pointer = UnsafePointer(array)

		XCTAssertEqual(100, *pointer)

		let endPointer = pointer + 9

		XCTAssertEqual(109, *endPointer)
	}

}
