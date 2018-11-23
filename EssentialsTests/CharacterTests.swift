//
//  CharacterTests.swift
//  Essentials
//
//  Created by Will Tyler on 8/12/18.
//
//

import XCTest


class CharacterTests: XCTestCase {

	func testIsDigit() {
		XCTAssertTrue(("0" as Character).isDigit)
		XCTAssertTrue(("1" as Character).isDigit)
		XCTAssertTrue(("2" as Character).isDigit)
		XCTAssertTrue(("3" as Character).isDigit)
		XCTAssertTrue(("4" as Character).isDigit)
		XCTAssertTrue(("5" as Character).isDigit)
		XCTAssertTrue(("6" as Character).isDigit)
		XCTAssertTrue(("7" as Character).isDigit)
		XCTAssertTrue(("8" as Character).isDigit)
		XCTAssertTrue(("9" as Character).isDigit)

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
