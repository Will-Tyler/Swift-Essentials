//
//  Number.swift
//  Essentials
//
//  Created by Will Tyler on 7/1/18.
//

import Foundation


fileprivate enum Sign {

	case positive
	case zero
	case negative

	mutating func toggle() {
		switch self {
		case .positive:
			self = .negative
		case .negative:
			self = .positive
		case.zero:
			break
		}
	}

}

public struct Number: Comparable, Strideable, SignedNumeric {

	private var data: String
	private var sign: Sign
	private var isPositive: Bool {
		get { return sign == .positive }
	}
	private var isNegative: Bool {
		get { return sign == .negative }
	}
	private var isZero: Bool {
		get { return sign == .zero }
	}
	private var radix: UInt = 10

	/// The numeric value of this Number returned as a String.
	public var value: String {
		get {
			var result = data

			// Remove leading zeroes if any
			while result.count > 1, result.first! == "0" {
				result.removeFirst()
			}

			if isNegative {
				result.insert("-", at: result.startIndex)
			}

			return result
		}
	}
	/// The distance of this Number from zero.
	public var magnitude: Number {
		get { return Number(from: data)! }
	}
	/// Returns a Number with the value of zero.
	public static var zero: Number {
		get {
			return Number()
		}
	}

	//MARK: Initializers
	/// Initialize a Number with a value of 0.
	public init() {
		data = "0"
		sign = .zero
	}
	/// Initialize a Number from another number.
	private init(from number: Number) {
		data = number.data
		sign = number.sign
	}
	/// Initialize a Number from a BinaryInteger.
	public init<Type: BinaryInteger>(exactly value: Type) {
		self.init(from: "\(value)")!
	}
	/// Initialize a Number from a String.
	public init?(from: String) {
		var copy = from

		if copy.isEmpty {
			copy = "0"
			sign = .zero
		}
		else if copy.first! == "-" {
			sign = .negative
			copy.removeFirst()

			if copy.isEmpty {
				return nil
			}
		}
		else {
			sign = copy == "0" ? .zero : .positive
		}

		assert(!copy.isEmpty)

		let digits: Set<Character> = Set("1234567890")

		for char in copy {
			if !digits.contains(char) { return nil }
		}

		data = copy
	}

	// MARK: ExpressibleByIntegerLiteral
	public typealias IntegerLiteralType = Int
	public init(integerLiteral value: IntegerLiteralType) {
		self.init(exactly: value)
	}

	// Change the radix that this Number is stored as.
	public func changeRadix(to newBase: UInt) {
		guard radix != newBase else {
			return
		}

		let lowerLimit: UInt = 2; let upperLimit: UInt = 25
		precondition((lowerLimit...upperLimit).contains(newBase), "The radix is limited to values between \(lowerLimit) and \(upperLimit) inclusive.")

		if radix != 10 {
			var baseTen = Number.zero

			for char in data.reversed() {
				let value = Int(String(char))
			}

			// TODO: Implement multiplication
		}
	}

	//MARK: Comparable
	public static func <(left: Number, right: Number) -> Bool {
		if left.isPositive != right.isPositive {
			return left.isNegative
		}

		if left.isPositive { // signs are equal
			if left.data.count != right.data.count {
				return left.data.count < right.data.count
			}

			for (offset, char) in left.data.enumerated() {
				if char != right.data[offset] {
					return char < right.data[offset]
				}
			}

			return false // should be equal at this point
		}
		else {
			if left.data.count != right.data.count { return left.data.count < right.data.count }

			for (offset, char) in left.data.enumerated() {
				if char != right.data[offset] { return char > right.data[offset] }
			}

			return false // equal
		}
	}

	// MARK: Strideable
	public typealias Stride = Number
	public func distance(to other: Number) -> Stride {
		return self - other
	}
	public func advanced(by number: Stride) -> Number {
		return self + number
	}

	private static func prepareStringsForArithmetic(_ left: String, _ right: String) -> (left: [Character], right: [Character]) {
		let leftReversed = left.reversed()
		let rightReversed = right.reversed()

		let longer: ReversedCollection<String>
		let shorter: ReversedCollection<String>

		if leftReversed.count >= rightReversed.count {
			longer = leftReversed
			shorter = rightReversed
		}
		else {
			longer = rightReversed
			shorter = leftReversed
		}

		let top: [Character] = Array(longer)
		let bottom: [Character] = {
			var array = Array(shorter)

			while (array.count < top.count) {
				array.append("0")
			}

			return array
		}()

		assert(top.count == bottom.count)

		return (top, bottom)
	}
	private static func addPositiveDecimalStrings(left: String, right: String) -> String {
		precondition(left.isPositiveDecimalNumber && right.isPositiveDecimalNumber, "Left and right must be positive, decimal, numeric values.")
		let preparedNumbers = prepareStringsForArithmetic(left, right)
		let top = preparedNumbers.left
		let bottom = preparedNumbers.right

		var sums = [Character]()
		var carryOver: UInt = 0
		for index in 0..<top.count {
			let leftChar = top[index]
			let rightChar = bottom[index]
			let result = UInt(String(leftChar))! + UInt(String(rightChar))! + carryOver

			sums.append(String(result).last!)

			if (result < 10) { // TODO: Handle radix
				carryOver = 0
			}
			else {
				carryOver = 1
			}
		}
		if carryOver > 0 {
			sums.append(String(carryOver).last!)
		}

		return String(sums.reversed())
	}

	private typealias DigitDiffResult = (diff: Character, sign: Sign)
	private static func subtractDigits(left: Character, right: Character) -> DigitDiffResult {
		precondition(left.isDigit && right.isDigit)

		if left == right {
			return ("0", .zero)
		}

		let sign: Sign = left > right ? .positive : .negative
		let diff = "\(Int8(String(left))! - Int8(String(right))!)"

		return (diff.last!, sign)
	}
	private static func subtractDecimalStrings(left: String, right: String) -> String {
		precondition(left.isPositiveDecimalNumber && right.isDecimalNumber)

		let preparedNumbers = prepareStringsForArithmetic(left, right)
		var top = preparedNumbers.left
		var bottom = preparedNumbers.right

		var diffs = [Character]()

		for index in 0..<top.count {
			let result = subtractDigits(left: top[index], right: bottom[index])

			if result.sign == .negative {
				var i = index
				while top[i] == "0" {
					top[i++] = "9"
				}
				top[i] = subtractDigits(left: top[i], right: "1").diff
				bottom[i] = subtractDigits(left: bottom[i], right: "1").diff
			}
			else {
				diffs.append(result.diff)
			}
		}

		return String(diffs.reversed())
	}
	private static func multiplyDecimalStrings(left: String, right: String) -> String {
		precondition(left.isPositiveDecimalNumber && right.isPositiveDecimalNumber)

		let preparedStrings = prepareStringsForArithmetic(left, right)
		let top = preparedStrings.left
		let bottom = preparedStrings.right
		let totalCount = top.count + bottom.count

		var products = [Character](repeating: "0" as Character, count: totalCount)
		// Cannot use multiplication algorithm from CS 251 yet because modulus is not defined. Quick solution is to use addition.
//		var carry = 0
//		for i in 0..<top.count {
//			carry = 0
//
//			for j in 0..<bottom.count {
//				let result = Int(String(top[i])) * Int(String(bottom[j])) + Int(String(products[i+j])) + carry
//
//				products[i+j] = result
//			}
//		}

		return String(products.reversed())
	}

	// MARK: Negation
	public static prefix func -(number: Number) -> Number {
		var newNumber = Number(from: number)

		newNumber.sign.toggle()

		return newNumber
	}

	// MARK: Operations
	public static func *(left: Number, right: Number) -> Number {
		if left.isZero || right.isZero {
			return Number.zero
		}
		assert(left.sign != .zero && right.sign != .zero)

		var newNumber = Number.zero

		newNumber.sign = left.sign == right.sign ? .positive : .negative
		for _ in stride(from: Number(exactly: 1), through: right, by: Number(exactly: 1) as Stride) {
			newNumber += left
		}

		return newNumber
	}
	public static func *=(left: inout Number, right: Number) {
		left = left * right
	}
	public static func +(left: Number, right: Number) -> Number {
		if left.isZero {
			return right
		}
		else if right.isZero {
			return left
		}

		var newNumber = Number.zero

		if left.sign == right.sign {
			newNumber.sign = left.sign
			newNumber.data = addPositiveDecimalStrings(left: left.data, right: right.data)
		}
		else {
			return left.isPositive ? left - right : right - left
		}

		return newNumber
	}
	public static func +=(left: inout Number, right: Number) {
		left = left + right
	}
	public static func -(left: Number, right: Number) -> Number {
		guard left != right else {
			return Number.zero
		}
		guard !left.isZero else {
			return -right
		}
		guard !right.isZero else {
			return left
		}

		assert(left.sign != .zero && right.sign != .zero)

		// We want the form a - b, where a, b > 0.
		// If a - -b, return a + b.
		// If -a - b, return -a + -b (negative addition).
		if left.sign != right.sign {
			return left + -right
		}

		// We should have a - b, where a, b > 0, now.
		assert(left.isPositive && right.isPositive)

		var newNumber = Number.zero

		newNumber.sign = left > right ? .positive : .negative
		newNumber.data = subtractDecimalStrings(left: left.data, right: right.data)

		return newNumber
	}
	public static func -=(left: inout Number, right: Number) {
		left = left - right
	}
	public static func %(left: Number, right: Number) -> Number {
		return Number.zero
	}

}
