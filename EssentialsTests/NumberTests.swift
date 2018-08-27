//
//  NumberTests.swift
//  EssentialsTests
//
//  Created by Will Tyler on 7/2/18.
//

import XCTest


class NumberTests: XCTestCase {

	func testInit() {
		let number = Number()

		XCTAssertEqual(number.value, "0")
		XCTAssertEqual(number, Number.zero)
	}

	func testInitWithInt() {
		var mynumber = Number(exactly: Int.max)

		XCTAssertEqual(mynumber.value, "\(Int.max)")

		mynumber = Number(exactly: -5)

		XCTAssertEqual(mynumber.value, "-5")

		mynumber = Number(exactly: 0)

		XCTAssertEqual(mynumber.value, "0")
		XCTAssertEqual(mynumber, Number.zero)
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
		var numbers = (first: Number(exactly: -123), second: Number(exactly: 123))

		XCTAssertLessThan(numbers.first, numbers.second)
		XCTAssertGreaterThan(numbers.second, numbers.first)

		XCTAssertNotEqual(numbers.first, numbers.second)
		XCTAssertEqual(numbers.first.magnitude, numbers.second)

		numbers = (first: Number(exactly: -563), second: Number(exactly: -562))

		XCTAssertLessThan(numbers.first, numbers.second)
		XCTAssertGreaterThan(numbers.second, numbers.first)

		XCTAssertNotEqual(numbers.first, numbers.second)

		numbers = (first: Number(exactly: 1934895), second: Number(exactly: 1934896))

		XCTAssertLessThan(numbers.first, numbers.second)
		XCTAssertGreaterThan(numbers.second, numbers.first)

		XCTAssertNotEqual(numbers.first, numbers.second)

		numbers = (first: Number(), second: Number())

		XCTAssertEqual(numbers.first, numbers.second)
	}

	private func testAdditionWithUInts(left: UInt, right: UInt) {
		let leftNumber = Number(exactly: left)
		let rightNumber = Number(exactly: right)
		let sum = leftNumber + rightNumber

		XCTAssertEqual(sum.value, "\(left + right)")
	}
	func testPositiveAddition() {
		testAdditionWithUInts(left: 111, right: 111)
		testAdditionWithUInts(left: 11111, right: 222)
		testAdditionWithUInts(left: 9, right: 9)
		testAdditionWithUInts(left: 999, right: 999)
		testAdditionWithUInts(left: 999, right: 1)
		testAdditionWithUInts(left: 0, right: 1)
		testAdditionWithUInts(left: 0, right: 0)
		testAdditionWithUInts(left: 100, right: 11)

		for _ in 0..<100 {
			let left = UInt(Random.from(0..<Int.max))
			let right = Random.from(0...(UInt(Int.max) - left))

			testAdditionWithUInts(left: left, right: right)
		}
	}

	private func testAdditionWithInts(left: Int, right: Int) {
		let leftNumber = Number(exactly: left)
		let rightNumber = Number(exactly: right)
		let sum = leftNumber + rightNumber

		XCTAssertEqual(sum.value, "\(left + right)")
	}
	func testNegativeAddition() {
		testAdditionWithInts(left: -111, right: -111)
		testAdditionWithInts(left: -11111, right: -222)
		testAdditionWithInts(left: -9, right: -9)
		testAdditionWithInts(left: -999, right: -999)
		testAdditionWithInts(left: -999, right: -1)

		for _ in 0..<100 {
			let left = Random.from((Int.min + 2)...0)
			let right = Random.from((Int.min+2 - left)...0)

			assert(left < 0 && right < 0)

			testAdditionWithInts(left: left, right: right)
		}
	}

	private func testAdditionFromStrings(left: String, right: String, expecting result: String) {
		let leftNumber = Number(from: left)!
		let rightNumber = Number(from: right)!
		let sum = leftNumber + rightNumber

		XCTAssertEqual(sum.value, result)
	}

	func testPositiveAdditionHugeNumbers() {
		testAdditionFromStrings(left: "\(UInt.max)0", right: "1234567890987654321234567890", expecting: "1234568075455095058330084040")
	}

	func testNegativeAdditionHugeNumbers() {
		testAdditionFromStrings(left: "-\(UInt.max)0", right: "-1234567890987654321234567890", expecting: "-1234568075455095058330084040")
	}

	func testAdditionAndAssignment() {
		var myNumber = Number()

		myNumber += Number(exactly: 5)

		XCTAssertEqual(myNumber.value, "5")

		myNumber += Number(exactly: 14)

		XCTAssertEqual(myNumber.value, "19")

		myNumber += Number(exactly: 199)

		XCTAssertEqual(myNumber.value, "\(199 + 19)")

		myNumber += Number(from: "1234567890987654321")!

		XCTAssertEqual(myNumber.value, "1234567890987654539")
	}

	func testNegation() {
		let myPositive = Number(exactly: 5)

		XCTAssertEqual((-myPositive).value, "-5")

		let myNegative = Number(exactly: -5)

		XCTAssertEqual((-myNegative).value, "5")

		let zero = Number.zero

		XCTAssertEqual((-zero).value, "0")
	}

	private func testSubtractionWithInts(left: Int, right: Int) {
		let leftNumber = Number(exactly: left)
		let rightNumber = Number(exactly: right)
		let difference = leftNumber - rightNumber

		XCTAssertEqual(difference.value, "\(left - right)")
	}

	func testSubtractionWithZeros() {
		testSubtractionWithInts(left: 0, right: 0)
		testSubtractionWithInts(left: 38018, right: 0)
		testSubtractionWithInts(left: 0, right: 4924)
		testSubtractionWithInts(left: -29492, right: 0)
		testSubtractionWithInts(left: 0, right: -2472978)
	}

	func testSubtractionEqual() {
		testSubtractionWithInts(left: 1, right: 1)
		testSubtractionWithInts(left: -1, right: -1)
		testSubtractionWithInts(left: 5, right: 5)
		testSubtractionWithInts(left: -5, right: -5)
		testSubtractionWithInts(left: 103, right: 103)
		testSubtractionWithInts(left: -103, right: -103)
	}

	func testPositiveLeftSubtraction() {
		testSubtractionWithInts(left: 9, right: 6)
		testSubtractionWithInts(left: 132, right: 6)
		testSubtractionWithInts(left: 176, right: 87)
		testSubtractionWithInts(left: 8888, right: 3581)
		testSubtractionWithInts(left: 1000000000, right: 2)
	}

	func testPositiveRightSubtraction() {
		testSubtractionWithInts(left: 8, right: 9)
		testSubtractionWithInts(left: 8, right: 18)
	}

	private func testMultiplicationWithInts(left: Int, right: Int) {
		let leftNumber = Number(exactly: left)
		let rightNumber = Number(exactly: right)
		let product = leftNumber * rightNumber

		XCTAssertEqual(product.value, "\(left * right)")
	}

	func testMultiplication() {
//		testMultiplicationWithInts(left: 0, right: 0)
//		testMultiplicationWithInts(left: 0, right: 1)
//		testMultiplicationWithInts(left: 1, right: 0)
//		testMultiplicationWithInts(left: 1, right: 1)
//		testMultiplicationWithInts(left: -1, right: 1)
//		testMultiplicationWithInts(left: 1, right: -1)
//		testMultiplicationWithInts(left: -1, right: -1)
//		testMultiplicationWithInts(left: 5, right: 5)
//		testMultiplicationWithInts(left: 5, right: -5)
//		testMultiplicationWithInts(left: -5, right: 5)
//		testMultiplicationWithInts(left: -5, right: -5)
//		testMultiplicationWithInts(left: 5, right: 6)
//		testMultiplicationWithInts(left: 6, right: 5)
	}

}
