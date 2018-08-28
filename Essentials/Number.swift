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

	private var data: String {
		didSet {
			data.removeLeadingZeroes()
		}
	}
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
	static let minRadix = 2
	static let maxRadix = 36

	/// The numeric value of this Number returned as a String.
	public var value: String {
		get {
			var result = data

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

	// MARK: Initializers
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
	public init?(from string: String) {
		if !string.isValidNumber() {
			return nil
		}

		var copy = string

		copy.removeLeadingZeroes()

		if copy == "0" {
			sign = .zero
		}
		else if copy.first! == "-" {
			sign = .negative
			copy.removeFirst()
		}
		else {
			sign = .positive
		}

		data = copy
	}

	// MARK: ExpressibleByIntegerLiteral
	public typealias IntegerLiteralType = Int
	public init(integerLiteral value: IntegerLiteralType) {
		self.init(exactly: value)
	}

	// Change the radix that this Number is stored as.
//	public func changeRadix(to newBase: UInt) {
//		guard radix != newBase else {
//			return
//		}
//
//		let lowerLimit: UInt = 2; let upperLimit: UInt = 25
//		precondition((lowerLimit...upperLimit).contains(newBase), "The radix is limited to values between \(lowerLimit) and \(upperLimit) inclusive.")
//
//		if radix != 10 {
//			var baseTen = Number.zero
//
//			for char in data.reversed() {
//				let value = Int(String(char))
//			}
//
//			// TODO: Implement multiplication
//		}
//	}

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
		return other - self
	}
	public func advanced(by number: Stride) -> Number {
		return self + number
	}

	private static func prepareStringsForArithmetic(_ left: String, _ right: String) -> (greater: [Character], lesser: [Character]) {
		let greater = left > right ? left : right
		let lesser = greater == left ? right : left

		let greaterReversed = greater.reversed()
		let lesserReversed = lesser.reversed()

		let longer: ReversedCollection<String>
		let shorter: ReversedCollection<String>

		if greaterReversed.count >= lesserReversed.count {
			longer = greaterReversed
			shorter = lesserReversed
		}
		else {
			longer = lesserReversed
			shorter = greaterReversed
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
		let top = preparedNumbers.greater
		let bottom = preparedNumbers.lesser

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

	private static func subtractPositiveDecimalStrings(left: String, right: String) -> String {
		precondition(left.isPositiveDecimalNumber && right.isPositiveDecimalNumber)

		let preparedNumbers = prepareStringsForArithmetic(left, right)
		let top = preparedNumbers.greater
		let bottom = preparedNumbers.lesser

		assert(top.count == bottom.count)

		var diffs = [Character]()
		var carryUnder = 0
		for index in 0..<top.count {
			let leftChar = top[index]
			let rightChar = bottom[index]
			var result = Int(String(leftChar))! - (Int(String(rightChar))! + carryUnder)

			if result >= 0 {
				carryUnder = 0
			}
			else {
				result += 10 // TODO: Handle radix
				carryUnder = 1
			}

			diffs.append(String(result).last!)
		}

		return String(diffs.reversed())
	}
	private static func multiplyDecimalStrings(left: String, right: String) -> String {
		precondition(left.isPositiveDecimalNumber && right.isPositiveDecimalNumber)

		let preparedStrings = prepareStringsForArithmetic(left, right)
		let top = preparedStrings.greater
		let bottom = preparedStrings.lesser
		let totalCount = top.count + bottom.count

		let products = [Character](repeating: "0" as Character, count: totalCount)
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
//		for _ in stride(from: Number(exactly: 1), through: right, by: Number(exactly: 1) as Stride) {
//			newNumber += left
//		}

		return newNumber
	}
	public static func *=(left: inout Number, right: Number) {
		left = left * right
	}
	public static func +(left: Number, right: Number) -> Number {
		guard !left.isZero else {
			return right
		}
		guard !right.isZero else {
			return left
		}

		// Looking for the form a + b or -a + -b, where a, b > 0.
		guard left.sign == right.sign else {
			if left.isPositive { // a + -b == a - b
				return left - -right
			}
			else { // -a + b == b - a
				return right - -left
			}
		}

		var newNumber = Number.zero

		newNumber.sign = left.sign
		newNumber.data = addPositiveDecimalStrings(left: left.data, right: right.data)

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
		// If -a - -b, which equals -a + b, return b - a.
		else if left.isNegative {
			return -right - -left
		}

		// We should have a - b, where a, b > 0, now.
		assert(left.isPositive && right.isPositive)

		var newNumber = Number.zero

		newNumber.sign = left > right ? .positive : .negative
		newNumber.data = subtractPositiveDecimalStrings(left: left.data, right: right.data)

		return newNumber
	}
	public static func -=(left: inout Number, right: Number) {
		left = left - right
	}
	public static func %(left: Number, right: Number) -> Number {
		return Number.zero
	}

}
