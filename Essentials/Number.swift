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

public struct Number: Comparable {

	private var data: String
	private var sign: Sign
	private var isPositive: Bool {
		get { return sign == .positive }
//		set {
//			if data == "0" {
//				sign = .zero
//			}
//			else if newValue {
//				sign = .positive
//			}
//			else {
//				sign = .negative
//			}
//		}
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
	public init<Type: BinaryInteger>(with value: Type) {
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

	//MARK: Comparable
	public static func <(left: Number, right: Number) -> Bool {
		if left.isPositive != right.isPositive { return left.isNegative }

		if left.isPositive { // signs are equal
			if left.data.count != right.data.count { return left.data.count < right.data.count }

			for (offset, char) in left.data.enumerated() {
				if char != right.data[offset] { return char < right.data[offset] }
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

	private typealias DigitResult = (sum: Character, carryOver: Character?)
	private static func addDigits(left: Character, right: Character) -> DigitResult {
		precondition(left.isDigit && right.isDigit, "Make sure that left and right are digits.")

		let result = "\(Int8(String(left))! + Int8(String(right))!)"

		assert(result.count >= 1 && result.count <= 2, "Got a result that was too big.")

		let sum = result.last!
		let leftOver: Character? = result.count == 2 ? result.first! : nil

		return (sum, leftOver)
	}
	private static func addPositiveDecimalStrings(left: String, right: String) -> String {
		precondition(left.isPositiveDecimalNumber && right.isPositiveDecimalNumber, "Left and right must be positive, decimal, numeric values.")

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
		var sums = [Character]()

		for index in 0..<top.count {
			let leftChar = top[index]
			let rightChar = bottom[index]
			let result = addDigits(left: leftChar, right: rightChar)

			if index < sums.count {
				let newResult = addDigits(left: sums[index], right: result.sum)

				sums[index] = newResult.sum

				if let remainder = newResult.carryOver {
					sums.append(remainder)
				}
			}
			else if index == sums.count {
				sums.append(result.sum)
			}

			if let remainder = result.carryOver {
				sums.append(remainder)
			}
		}

		return String(sums.reversed())
	}
	private static func subtractDigits(left: Character, right: Character) -> Character {
		precondition(left.isDigit && right.isDigit)

		let diff = "\(Int8(String(left))! - Int8(String(right))!)"

		return diff.last!
	}
	private static func subtractDecimalStrings(left: String, right: String) -> String {
		precondition(left.isPositiveDecimalNumber && right.isDecimalNumber)

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
		var diffs = [Character]()

		for index in 0..<top.count {
			diffs.append(subtractDigits(left: top[index], right: bottom[index]))
		}

		return String(diffs.reversed())
	}

	//MARK: Negation
	public static prefix func -(number: Number) -> Number {
		var newNumber = Number(from: number)

		newNumber.sign.toggle()

		return newNumber
	}

	//MARK: Operations
	public static func *(left: Number, right: Number) -> Number {
		return Number()
	}
	public static func *=(left: inout Number, right: Number) {}
	public static func +(left: Number, right: Number) -> Number {
		if left.isZero {
			return right
		}
		else if right.isZero {
			return left
		}

		var newNumber = Number()

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
		if left.isPositive != right.isPositive {
			return left + (-right)
		}
		if left == right {
			return Number()
		}
		if left.isNegative {
			return right.magnitude - left.magnitude
		}

		var newNumber = Number()

		newNumber.sign = left.magnitude >= right.magnitude ? .positive : .negative
		newNumber.data = subtractDecimalStrings(left: left.data, right: right.data)

		return newNumber
	}
	public static func -=(left: inout Number, right: Number) {
		left = left - right
	}

}
