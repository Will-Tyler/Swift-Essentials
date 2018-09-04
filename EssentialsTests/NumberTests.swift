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

		XCTAssertNil(zero)

		let hugeNumber = "\(Int.max)0"

		XCTAssertEqual(Number(from: hugeNumber)?.value, hugeNumber)

		let hugeNegative = "\(Int.min)0"

		XCTAssertEqual(Number(from: hugeNegative)?.value, hugeNegative)
	}

	func testExpressibleByInteger() {
		var mine: Number = 23

		XCTAssertEqual(mine, Number(exactly: 23))

		mine = 0

		XCTAssertEqual(mine, Number.zero)

		mine = -145

		XCTAssertEqual(mine, Number(exactly: -145))
		XCTAssertNotEqual(mine, Number(exactly: -143))
	}

	func testExpressibleByString() {
		var mine: Number = "23"

		XCTAssertEqual(mine, 23 as Number)

		mine = "0"

		XCTAssertEqual(mine, Number.zero)

		let myCoercion = "-145" as Number

		XCTAssertEqual(myCoercion, Number(from: "-145"))
	}

	func testMagnitude() {
		let number = Number(from: "\(Int.min+1)")!

		XCTAssertEqual(number.magnitude.value, "\(Int.max)")
	}

	func testEquatable() {
		var left = Number(exactly: 123)
		var right = Number(from: "123")

		XCTAssertEqual(left, right)

		left = Number(exactly: 0)
		right = Number.zero

		XCTAssertEqual(left, right)

		left = Number(exactly: -321)
		right = Number(from: "-00321")

		XCTAssertEqual(left, right)
	}

	private func assertLessThanWithInts(_ left: Int, lessThan right: Int) {
		let expected = left < right
		let actual = Number(integerLiteral: left) < Number(integerLiteral: right)

		XCTAssertEqual(actual, expected)
	}

	func testLessThan() {
		for _ in 0..<100 {
			let first = Int(Random.from(Int16.min...Int16.max))
			let second = Int(Random.from(Int16.min...Int16.max))

			assertLessThanWithInts(first, lessThan: second)
		}
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

	func testMixedAddition() {
		testAdditionWithInts(left: -1, right: 2)
		testAdditionWithInts(left: 2, right: -1)
		testAdditionWithInts(left: -2, right: 1)
		testAdditionWithInts(left: 1, right: -2)
		testAdditionWithInts(left: -10, right: 20)
		testAdditionWithInts(left: 20, right: -10)
		testAdditionWithInts(left: 298420984, right: -49279)
		testAdditionWithInts(left: 4785, right: -3287478374)
		testAdditionWithInts(left: -4287827874, right: 239834)

		for _ in 0..<100 {
			let left = Int(Random.from(Int16.min...0))
			let right = Int(Random.from(0...Int16.max))

			testAdditionWithInts(left: left, right: right)
			testAdditionWithInts(left: right, right: left)
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
		var myNumber = Number.zero

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

	// Left > right
	func testPositiveLeftSubtraction() {
		testSubtractionWithInts(left: 9, right: 6)
		testSubtractionWithInts(left: 132, right: 6)
		testSubtractionWithInts(left: 176, right: 87)
		testSubtractionWithInts(left: 8888, right: 3581)
		testSubtractionWithInts(left: 1000000000, right: 2)
	}

	// Left < right
	func testPositiveRightSubtraction() {
		testSubtractionWithInts(left: 1, right: 2)
		testSubtractionWithInts(left: 8, right: 9)
		testSubtractionWithInts(left: 8, right: 18)
		testSubtractionWithInts(left: 9, right: 18)
		testSubtractionWithInts(left: 34, right: 2983492)
		testSubtractionWithInts(left: 1, right: 100000000)
	}

	// Left > right
	func testNegativeLeftSubtraction() {
		testSubtractionWithInts(left: 1, right: -1)
		testSubtractionWithInts(left: 193891, right: -2989)
		testSubtractionWithInts(left: 2, right: -91849)
		testSubtractionWithInts(left: -1, right: -2)
		testSubtractionWithInts(left: -1, right: -11)
		testSubtractionWithInts(left: -10, right: -199)
		testSubtractionWithInts(left: -1, right: -10000000000)
		testSubtractionWithInts(left: -2442, right: -849278)
		testSubtractionWithInts(left: -29, right: -92497)
	}

	// Right > left
	func testNegativeRightSubtraction() {
		testSubtractionWithInts(left: -2, right: -1)
		testSubtractionWithInts(left: -9489, right: 1)
		testSubtractionWithInts(left: -49028, right: -2094)
		testSubtractionWithInts(left: -2894892894, right: 948240)
	}

	func testSubtractionRandom() {
		for _ in 0..<100 {
			let left = Int(Random.from(0...Int16.max))
			let right = Int(Random.from(Int16.min...0))

			testSubtractionWithInts(left: left, right: right)
		}
	}

	private func testSubtractionWithStrings(_ left: String, minus right: String, shouldEqual expectedValue: String) {
		precondition(left.isDecimalNumber && right.isDecimalNumber)

		let leftNumber = Number(from: left)!
		let rightNumber = Number(from: right)!

		XCTAssertEqual((leftNumber - rightNumber).value, expectedValue)
	}

	func testLargeSubtraction() {
		testSubtractionWithStrings("3892485972934582039840298023398534928739482938471928748716387648728", minus: "3892485972934582039840298023398534928739482938471928748716387648728", shouldEqual: "0")
		testSubtractionWithStrings("058429875982704509284098502974087208014892365498", minus: "10", shouldEqual: "58429875982704509284098502974087208014892365488")
		testSubtractionWithStrings("10", minus: "058429875982704509284098502974087208014892365498", shouldEqual: "-58429875982704509284098502974087208014892365488")
	}
	
	func testSubtractionAndAssignment() {
		var myNumber: Number = 0

		myNumber -= 1

		XCTAssertEqual(myNumber.value, "-1")

		myNumber -= 10

		XCTAssertEqual(myNumber.value, "-11")

		myNumber -= 999

		XCTAssertEqual(myNumber.value, "-1010")

		myNumber = 1000
		myNumber -= 999

		XCTAssertEqual(myNumber.value, "1")

		myNumber -= myNumber

		XCTAssertEqual(myNumber.value, "0")
		XCTAssertEqual(myNumber, Number.zero)
	}

	func testStrideable() {
		let high = Number(exactly: 10)
		let low = Number(exactly: -10)
		let diff = high - low // should be 20

		XCTAssertEqual(low.distance(to: high), diff)
		XCTAssertEqual(low.advanced(by: diff), high)

		var reference: Number = 0
		var ranStride = false
		for test in stride(from: 0 as Number, through: 9, by: 1) {
			defer { reference += 1 }

			if !ranStride {
				ranStride = true
			}

			XCTAssertEqual(test, reference)
		}

		XCTAssert(ranStride, "Never ran stride.")
	}

	private func testMultiplicationWithInts(left: Int, right: Int) {
		let leftNumber = Number(exactly: left)
		let rightNumber = Number(exactly: right)
		let product = leftNumber * rightNumber

		XCTAssertEqual(product.value, "\(left * right)")
	}

	func testMultiplicationWithZeroes() {
		testMultiplicationWithInts(left: 0, right: 0)
		testMultiplicationWithInts(left: 0, right: 1)
		testMultiplicationWithInts(left: 1, right: 0)
		testMultiplicationWithInts(left: 98299, right: 0)
		testMultiplicationWithInts(left: 0, right: 94829)
		testMultiplicationWithInts(left: -928498, right: 0)
		testMultiplicationWithInts(left: 0, right: -24892)
	}

	func testMultiplicationPositives() {
		testMultiplicationWithInts(left: 1, right: 1)
		testMultiplicationWithInts(left: 5, right: 5)
		testMultiplicationWithInts(left: 5, right: 6)
		testMultiplicationWithInts(left: 6, right: 5)
	}

	func testMultiplicationNegatives() {
		testMultiplicationWithInts(left: -1, right: -1)
		testMultiplicationWithInts(left: -5, right: -5)
	}

	func testMultiplicationMixed() {
		testMultiplicationWithInts(left: -1, right: 1)
		testMultiplicationWithInts(left: 1, right: -1)
		testMultiplicationWithInts(left: 5, right: -5)
		testMultiplicationWithInts(left: -5, right: 5)
	}

	func testIncrementable() {
		var number: Number = -1

		XCTAssertEqual((number++).value, "-1")
		XCTAssertEqual(number.value, "0")

		XCTAssertEqual(number++.value, "0")
		XCTAssertEqual(number.value, "1")

		XCTAssertEqual(number++.value, "1")
		XCTAssertEqual(number.value, "2")

		number = -1

		XCTAssertEqual((++number).value, "0")
		XCTAssertEqual(number.value, "0")

		XCTAssertEqual((++number).value, "1")
		XCTAssertEqual(number.value, "1")

		XCTAssertEqual((++number).value, "2")
		XCTAssertEqual(number, 2)
	}

	func testDecrementable() {
		var number: Number = 1

		XCTAssertEqual(number--, 1)
		XCTAssertEqual(number, 0)

		XCTAssertEqual(number--, 0)
		XCTAssertEqual(number, -1)

		XCTAssertEqual(number--, -1)
		XCTAssertEqual(number, -2)

		number = 1

		XCTAssertEqual(--number, 0)
		XCTAssertEqual(number, 0)

		XCTAssertEqual(--number, -1)
		XCTAssertEqual(number, -1)

		XCTAssertEqual(--number, -2)
		XCTAssertEqual(number, -2)
	}

}
