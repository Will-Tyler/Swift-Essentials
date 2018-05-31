//
//  IntExtTests.swift
//  EssentialsTests
//
//  Created by Will Tyler on 5/19/18.
//  Copyright © 2018 Will Tyler. All rights reserved.
//

import XCTest

class BinaryIntegerExtTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

	func testPostfixIncrement() {
		var myNumber: Int = 42

		XCTAssertEqual(myNumber++, 42)
		XCTAssertEqual(myNumber, 43)

		XCTAssertEqual(myNumber++, 43)
		XCTAssertEqual(myNumber, 44)

		XCTAssertEqual(myNumber++, 44)
		XCTAssertEqual(myNumber, 45)

		myNumber = -1024

		XCTAssertEqual(myNumber++, -1024)
		XCTAssertEqual(myNumber, -1023)

		XCTAssertEqual(myNumber++, -1023)
		XCTAssertEqual(myNumber, -1022)

		XCTAssertEqual(myNumber++, -1022)
		XCTAssertEqual(myNumber, -1021)

		let myString = "The quick brown fox jumps over the lazy dog."

		myNumber = 0

		XCTAssertEqual(myString[myNumber++], "T")
		XCTAssertEqual(myString[myNumber++], "h")
		XCTAssertEqual(myString[myNumber++], "e")
	}

	func testPrefixIncrement() {
		var myNumber: Int = 42

		XCTAssertEqual(++myNumber, 43)
		XCTAssertEqual(myNumber, 43)

		XCTAssertEqual(++myNumber, 44)
		XCTAssertEqual(myNumber, 44)

		XCTAssertEqual(++myNumber, 45)
		XCTAssertEqual(myNumber, 45)

		myNumber = -1024

		XCTAssertEqual(++myNumber, -1023)
		XCTAssertEqual(myNumber, -1023)

		XCTAssertEqual(++myNumber, -1022)
		XCTAssertEqual(myNumber, -1022)

		XCTAssertEqual(++myNumber, -1021)
		XCTAssertEqual(myNumber, -1021)

		let myString = "The quick brown fox jumps over the lazy dog."

		myNumber = 0

		XCTAssertEqual(myString[++myNumber], "h")
		XCTAssertEqual(myString[++myNumber], "e")
		XCTAssertEqual(myString[++myNumber], " ")
	}

	func testPostfixDecrement() {
		var myNumber = 42

		XCTAssertEqual(myNumber--, 42)
		XCTAssertEqual(myNumber, 41)

		XCTAssertEqual(myNumber--, 41)
		XCTAssertEqual(myNumber, 40)

		XCTAssertEqual(myNumber--, 40)
		XCTAssertEqual(myNumber, 39)

		myNumber = -1024

		XCTAssertEqual(myNumber--, -1024)
		XCTAssertEqual(myNumber, -1025)

		XCTAssertEqual(myNumber--, -1025)
		XCTAssertEqual(myNumber, -1026)

		XCTAssertEqual(myNumber--, -1026)
		XCTAssertEqual(myNumber, -1027)

		let myString = "The quick brown fox jumps over the lazy dog."

		myNumber = myString.count-1

		XCTAssertEqual(myString[myNumber--], ".")
		XCTAssertEqual(myString[myNumber--], "g")
		XCTAssertEqual(myString[myNumber--], "o")
	}

	func testPrefixDecrement() {
		var myNumber = 42

		XCTAssertEqual(--myNumber, 41)
		XCTAssertEqual(myNumber, 41)

		XCTAssertEqual(--myNumber, 40)
		XCTAssertEqual(myNumber, 40)

		XCTAssertEqual(--myNumber, 39)
		XCTAssertEqual(myNumber, 39)

		myNumber = -1024

		XCTAssertEqual(--myNumber, -1025)
		XCTAssertEqual(myNumber, -1025)

		XCTAssertEqual(--myNumber, -1026)
		XCTAssertEqual(myNumber, -1026)

		XCTAssertEqual(--myNumber, -1027)
		XCTAssertEqual(myNumber, -1027)

		let myString = "The quick brown fox jumps over the lazy dog."

		myNumber = myString.count-1

		XCTAssertEqual(myString[--myNumber], "g")
		XCTAssertEqual(myString[--myNumber], "o")
		XCTAssertEqual(myString[--myNumber], "d")
	}

	func testUInt() {
		var number: UInt = 42

		XCTAssertEqual(number++, 42)
		XCTAssertEqual(number, 43)

		XCTAssertEqual(++number, 44)
		XCTAssertEqual(number, 44)

		XCTAssertEqual(number--, 44)
		XCTAssertEqual(number, 43)

		XCTAssertEqual(--number, 42)
		XCTAssertEqual(number, 42)
	}

}



























































