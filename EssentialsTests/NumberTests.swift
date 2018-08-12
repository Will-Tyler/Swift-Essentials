//
//  NumberTests.swift
//  EssentialsTests
//
//  Created by Will Tyler on 7/2/18.
//

import XCTest


class NumberTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
		super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testInit() {
		XCTAssertEqual(Number().value, "0")
	}

	func testInitWithInt() {
		var mynumber = Number(with: Int.max)

		XCTAssertEqual(mynumber.value, "\(Int.max)")

		mynumber = Number(with: -5)

		XCTAssertEqual(mynumber.value, "-5")
	}

	func testInitFromString() {
		let emptyNegative = Number(from: "-")

		XCTAssertNil(emptyNegative)

		let zero = Number(from: "")

		XCTAssertNotNil(zero)
		XCTAssertEqual(zero?.value, "0")

		let hugeNumber = "\(Int.max)0"

		XCTAssertEqual(Number(from: hugeNumber)?.value, hugeNumber)

		let hugeNegative = "\(Int.min)0"

		XCTAssertEqual(Number(from: hugeNegative)?.value, hugeNegative)
	}

	func testMagnitude() {
		let number = Number(from: "\(Int.min+1)")!

		XCTAssertEqual(number.magnitude.value, "\(Int.max)")
	}

	func testComparable() {
		var numbers = (first: Number(with: -123), second: Number(with: 123))

		XCTAssertLessThan(numbers.first, numbers.second)
		XCTAssertGreaterThan(numbers.second, numbers.first)

		XCTAssertNotEqual(numbers.first, numbers.second)
		XCTAssertEqual(numbers.first.magnitude, numbers.second)

		numbers = (first: Number(with: -563), second: Number(with: -562))

		XCTAssertLessThan(numbers.first, numbers.second)
		XCTAssertGreaterThan(numbers.second, numbers.first)

		XCTAssertNotEqual(numbers.first, numbers.second)

		numbers = (first: Number(with: 1934895), second: Number(with: 1934896))

		XCTAssertLessThan(numbers.first, numbers.second)
		XCTAssertGreaterThan(numbers.second, numbers.first)

		XCTAssertNotEqual(numbers.first, numbers.second)

		numbers = (first: Number(), second: Number())

		XCTAssertEqual(numbers.first, numbers.second)
	}

	func testPlus() {
		var left = Number(from: "111")!
		var right = Number(from: "111")!

		var sum = left + right

		XCTAssertEqual(sum.value, "222")

		left = Number(from: "11111")!
		right = Number(from: "222")!

		sum = left + right

		XCTAssertEqual(sum.value, "11333")

		left = Number(with: 9)
		right = Number(with: 9)

		sum = left + right
		
		XCTAssertEqual(sum.value, "18")

		left = Number(with: 999)
		right = Number(with: 999)

		sum = left + right

		XCTAssertEqual(sum.value, "\(999 + 999)")

		left = Number(with: 999)
		right = Number(with: 1)

		sum = left + right

		XCTAssertEqual(sum.value, "1000")

		let max = Int.max / 2
		let upper = Random.from(0..<max)
		let lower = Random.from(0..<max)

		left = Number(with: upper)
		right = Number(with: lower)

		sum = left + right

		XCTAssertEqual(sum.value, "\(upper + lower)")
	}

}
