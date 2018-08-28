//
//  StringExtTests.swift
//  EssentialsTests
//
//  Created by Will Tyler on 5/19/18.
//  Copyright © 2018 Will Tyler. All rights reserved.
//

import XCTest


class StringTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

	func testIntSubscript() {
		var myString = "Hello, I am having quite a good time testing my Swift code."

		XCTAssertEqual(myString[0], "H")
		XCTAssertEqual(myString[1], "e")
		XCTAssertEqual(myString[myString.count-1], ".")

		myString = "Hola, Señor! Estoy hablando español!"

		XCTAssertEqual(myString[myString.count-1], "!")
		XCTAssertEqual(myString[myString.count-4], "ñ")
		XCTAssertEqual(myString[8], "ñ")

		myString = "˚¨¥ƒ©ˆ¥†∂ˆ©π¨ƒˆ¥®∂¶•πªˆ˙∫√·‡ﬂ°‡ﬁﬂ›ﬁ‡"

		var myIndex = 0

		XCTAssertEqual(myString[myIndex++], "˚")
		XCTAssertEqual(myString[myIndex++], "¨")
		XCTAssertEqual(myString[myIndex++], "¥")

		myIndex = myString.count-1

		XCTAssertEqual(myString[myIndex--], "‡")
		XCTAssertEqual(myString[myIndex--], "ﬁ")
		XCTAssertEqual(myString[myIndex--], "›")
	}

	func testIsDecimalNumber() {
		XCTAssert("123".isDecimalNumber)

		XCTAssertFalse("1234283920288a".isDecimalNumber)

		XCTAssertFalse("4893892a9829924".isDecimalNumber)

		XCTAssertFalse("a428981983".isDecimalNumber)

		XCTAssert("-2937238728748279378947287319937".isDecimalNumber)

		XCTAssert("0".isDecimalNumber)

		XCTAssertFalse("".isDecimalNumber)

		XCTAssertFalse("Hello".isDecimalNumber)
	}

	func testIsPositiveDecimalNumber() {
		XCTAssert("123".isPositiveDecimalNumber)

		XCTAssert("928394829".isPositiveDecimalNumber)

		XCTAssertFalse("".isPositiveDecimalNumber)

		XCTAssertFalse("-2408".isPositiveDecimalNumber)

		XCTAssertFalse("492894 283492".isPositiveDecimalNumber)

		XCTAssertFalse("a29834992".isPositiveDecimalNumber)

		XCTAssertFalse("49842948928 ".isPositiveDecimalNumber)
	}

	// TODO: Finish testing this method
	func testIsValidNumber() {
		var string = ""

		XCTAssertFalse(string.isValidNumber())

		string = "-"
		XCTAssertFalse(string.isValidNumber())

		string = "1001"
		XCTAssert(string.isValidNumber(forRadix: 2))
		XCTAssert(string.isValidNumber(forRadix: 3))
		XCTAssert(string.isValidNumber())

		string = "102102102101201021021"
		XCTAssert(string.isValidNumber(forRadix: 3))
		XCTAssertFalse(string.isValidNumber(forRadix: 2))
		XCTAssert(string.isValidNumber(forRadix: 4))
		XCTAssert(string.isValidNumber())

		string = "-10"
		XCTAssert(string.isValidNumber(forRadix: 2))
		XCTAssert(string.isValidNumber(forRadix: 3))
		XCTAssert(string.isValidNumber())
		XCTAssert(string.isValidNumber(forRadix: 36))

		string = "-0000sadj4z"
		XCTAssert(string.isValidNumber(forRadix: 36))
		XCTAssertFalse(string.isValidNumber(forRadix: 35))
		XCTAssertFalse(string.isValidNumber(forRadix: 10))
		XCTAssertFalse(string.isValidNumber(forRadix: 2))
	}

	func testRemoveLeadingZeroes() {
		var string = ""

		string.removeLeadingZeroes()
		XCTAssertEqual(string, "")

		string = "-"
		string.removeLeadingZeroes()
		XCTAssertEqual(string, "-")

		string = "-0"
		string.removeLeadingZeroes()
		XCTAssertEqual(string, "-0")

		string = "-01"
		string.removeLeadingZeroes()
		XCTAssertEqual(string, "-1")

		string = "01"
		string.removeLeadingZeroes()
		XCTAssertEqual(string, "1")

		string = "-0000000024900000"
		string.removeLeadingZeroes()
		XCTAssertEqual(string, "-24900000")

		string = "02839844982139830"
		string.removeLeadingZeroes()
		XCTAssertEqual(string, "2839844982139830")
	}

}
