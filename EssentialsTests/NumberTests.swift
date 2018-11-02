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
		XCTAssertEqual(number, 0)
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
		assertLessThanWithInts(-2, lessThan: -1)
		assertLessThanWithInts(-1, lessThan: 0)
		assertLessThanWithInts(0, lessThan: 1)
		assertLessThanWithInts(1, lessThan: 2)

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

	private func testAdditionWithInts(_ left: Int, plus right: Int) {
		let leftNumber = Number(exactly: left)
		let rightNumber = Number(exactly: right)
		let sum = leftNumber + rightNumber

		XCTAssertEqual(sum.value, "\(left + right)")
	}

	func testNegativeAddition() {
		testAdditionWithInts(-111, plus: -111)
		testAdditionWithInts(-11111, plus: -222)
		testAdditionWithInts(-9, plus: -9)
		testAdditionWithInts(-999, plus: -999)
		testAdditionWithInts(-999, plus: -1)

		for _ in 0..<100 {
			let left = Random.from((Int.min + 2)...0)
			let right = Random.from((Int.min+2 - left)...0)

			assert(left < 0 && right < 0)

			testAdditionWithInts(left, plus: right)
		}
	}

	func testMixedAddition() {
		testAdditionWithInts(-1, plus: 2)
		testAdditionWithInts(2, plus: -1)
		testAdditionWithInts(-2, plus: 1)
		testAdditionWithInts(1, plus: -2)
		testAdditionWithInts(-10, plus: 20)
		testAdditionWithInts(20, plus: -10)
		testAdditionWithInts(298420984, plus: -49279)
		testAdditionWithInts(4785, plus: -3287478374)
		testAdditionWithInts(-4287827874, plus: 239834)

		for _ in 0..<100 {
			let left = Int(Random.from(Int16.min...0))
			let right = Int(Random.from(0...Int16.max))

			testAdditionWithInts(left, plus: right)
			testAdditionWithInts(right, plus: left)
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

	private func testSubtractionWithInts(_ left: Int, minus right: Int) {
		let leftNumber = Number(exactly: left)
		let rightNumber = Number(exactly: right)
		let difference = leftNumber - rightNumber

		XCTAssertEqual(difference.value, "\(left - right)")
	}

	func testSubtractionWithZeros() {
		testSubtractionWithInts(0, minus: 0)
		testSubtractionWithInts(38018, minus: 0)
		testSubtractionWithInts(0, minus: 4924)
		testSubtractionWithInts(-29492, minus: 0)
		testSubtractionWithInts(0, minus: -2472978)
	}

	func testSubtractionEqual() {
		testSubtractionWithInts(1, minus: 1)
		testSubtractionWithInts(-1, minus: -1)
		testSubtractionWithInts(5, minus: 5)
		testSubtractionWithInts(-5, minus: -5)
		testSubtractionWithInts(103, minus: 103)
		testSubtractionWithInts(-103, minus: -103)
	}

	// Left > right
	func testPositiveLeftSubtraction() {
		testSubtractionWithInts(9, minus: 6)
		testSubtractionWithInts(132, minus: 6)
		testSubtractionWithInts(176, minus: 87)
		testSubtractionWithInts(8888, minus: 3581)
		testSubtractionWithInts(1000000000, minus: 2)
	}

	// Left < right
	func testPositiveRightSubtraction() {
		testSubtractionWithInts(1, minus: 2)
		testSubtractionWithInts(8, minus: 9)
		testSubtractionWithInts(8, minus: 18)
		testSubtractionWithInts(9, minus: 18)
		testSubtractionWithInts(34, minus: 2983492)
		testSubtractionWithInts(1, minus: 100000000)
	}

	// Left > right
	func testNegativeLeftSubtraction() {
		testSubtractionWithInts(1, minus: -1)
		testSubtractionWithInts(193891, minus: -2989)
		testSubtractionWithInts(2, minus: -91849)
		testSubtractionWithInts(-1, minus: -2)
		testSubtractionWithInts(-1, minus: -11)
		testSubtractionWithInts(-10, minus: -199)
		testSubtractionWithInts(-1, minus: -10000000000)
		testSubtractionWithInts(-2442, minus: -849278)
		testSubtractionWithInts(-29, minus: -92497)
	}

	// Right > left
	func testNegativeRightSubtraction() {
		testSubtractionWithInts(-2, minus: -1)
		testSubtractionWithInts(-9489, minus: 1)
		testSubtractionWithInts(-49028, minus: -2094)
		testSubtractionWithInts(-2894892894, minus: 948240)
	}

	func testSubtractionRandom() {
		for _ in 0..<100 {
			let left = Int(Random.from(0...Int16.max))
			let right = Int(Random.from(Int16.min...0))

			testSubtractionWithInts(left, minus: right)
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

	private func testMultiplicationWithInts(_ left: Int, times right: Int) {
		let leftNumber = Number(exactly: left)
		let rightNumber = Number(exactly: right)
		let product = leftNumber * rightNumber

		XCTAssertEqual(product.value, "\(left * right)")
	}

	func testMultiplicationWithZeroes() {
		testMultiplicationWithInts(0, times: 0)
		testMultiplicationWithInts(0, times: 1)
		testMultiplicationWithInts(1, times: 0)
		testMultiplicationWithInts(98299, times: 0)
		testMultiplicationWithInts(0, times: 94829)
		testMultiplicationWithInts(-928498, times: 0)
		testMultiplicationWithInts(0, times: -24892)
	}

	func testMultiplicationPositives() {
		testMultiplicationWithInts(1, times: 1)
		testMultiplicationWithInts(5, times: 5)
		testMultiplicationWithInts(5, times: 6)
		testMultiplicationWithInts(6, times: 5)
	}

	func testMultiplicationNegatives() {
		testMultiplicationWithInts(-1, times: -1)
		testMultiplicationWithInts(-5, times: -5)
	}

	func testMultiplicationMixed() {
		testMultiplicationWithInts(-1, times: 1)
		testMultiplicationWithInts(1, times: -1)
		testMultiplicationWithInts(5, times: -5)
		testMultiplicationWithInts(-5, times: 5)
	}

	func testMultiplicationRandom() {
		for _ in 0..<100 {
			let left = Random.from(-64...63)
			let right = Random.from(-64...63)

			testMultiplicationWithInts(left, times: right)
		}
	}

	private func testDivisionWithInts(_ dividend: Int, dividedBy divisor: Int) {
		precondition(divisor != 0)

		let dividendNumber = Number(exactly: dividend)
		let divisorNumber = Number(exactly: divisor)
		let quotientNumber = (dividendNumber / divisorNumber)!;

		XCTAssertEqual(quotientNumber.value, "\(dividend / divisor)")
	}

	func testDivisionByZero() {
		let randomNumber = Number(exactly: Random.int)

		XCTAssertNil(randomNumber / 0)
	}

	func testDivisionByNonZeroPositives() {
		testDivisionWithInts(0, dividedBy: 1)
		testDivisionWithInts(4, dividedBy: 2)
		testDivisionWithInts(5, dividedBy: 2)
		testDivisionWithInts(15, dividedBy: 3)
		testDivisionWithInts(3, dividedBy: 15)
		testDivisionWithInts(99, dividedBy: 100)
		testDivisionWithInts(100, dividedBy: 100)
		testDivisionWithInts(492897, dividedBy: 948)
	}

	func testDivisionByNonZeroNegatives() {
		testDivisionWithInts(0, dividedBy: -1)
		testDivisionWithInts(-4, dividedBy: -2)
		testDivisionWithInts(-5, dividedBy: -2)
		testDivisionWithInts(-15, dividedBy: -3)
		testDivisionWithInts(-3, dividedBy: -15)
		testDivisionWithInts(-99, dividedBy: -100)
		testDivisionWithInts(-100, dividedBy: -100)
		testDivisionWithInts(-4294729, dividedBy: -4829)
		testDivisionWithInts(-654, dividedBy: -42894581)
	}

	func testDivisionByNonZeroMixed() {
		testDivisionWithInts(0, dividedBy: 48792847)
		testDivisionWithInts(-15, dividedBy: 3)
		testDivisionWithInts(25, dividedBy: -5)
		testDivisionWithInts(-5, dividedBy: 30)
		testDivisionWithInts(-289489533, dividedBy: 5465461)
		testDivisionWithInts(928974, dividedBy: -5949274)
	}

	func testDivisionByNonZeroRandoms() {
		for _ in 0..<100 {
			testDivisionWithInts(Int.random(in: Int(Int8.min)...Int(Int8.max)), dividedBy: Int.random(in: 1...Int(Int8.max)))
		}
	}

	private func testRemainderWithInts(_ left: Number, mod right: Number) {
		// TODO
	}

	func testRemainderPositives() {
		// TODO
	}

	func testRemainderNegatives() {
		// TODO
	}

	func testRemainderMixed() {
		// TODO
	}

	func testRemainderRandom() {
		// TODO
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
