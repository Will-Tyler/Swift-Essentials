//
//  CharacterTests.swift
//  Essentials
//
//  Created by Will Tyler on 8/12/18.
//
//

import XCTest


class CharacterTests: XCTestCase {

	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}

	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}

	func testIsDigit() {
		for i in 0...9 {
			XCTAssert(("\(i)" as! Character).isDigit)
		}

		XCTAssertFalse((" " as Character).isDigit)
		XCTAssertFalse(("a" as Character).isDigit)
	}

	func testIsBit() {
		XCTAssert(("0" as Character).isBit)
		XCTAssert(("1" as Character).isBit)

		XCTAssertFalse(("2" as Character).isBit)
		XCTAssertFalse((" " as Character).isBit)
		XCTAssertFalse(("a" as Character).isBit)
	}

}
