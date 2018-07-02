//
//  Number.swift
//  Essentials
//
//  Created by Will Tyler on 7/1/18.
//

import Foundation


public struct Number: Comparable {

	private var data: String
	private var sign: Sign

	public var value: String {
		get {
			var result = data

			if sign == .negative {
				result.insert("-", at: result.startIndex)
			}

			return result
		}
	}
	public var magnitude: Number {
		get {
			return Number(from: data)!
		}
	}

	//MARK: Initializers
	public init() {
		data = "0"
		sign = .positive
	}
	public init<Type: BinaryInteger>(with value: Type) {
		self.init(from: "\(value)")!
	}
	public init?(from: String) {
		var string = from

		if string.isEmpty { return nil }

		if string[0] == "-" {
			sign = .negative
			string.removeFirst()
			if string.isEmpty { return nil }
		}
		else {
			sign = .positive
		}

		let digits: Set<Character> = Set("1234567890")
		for char in string {
			if !digits.contains(char) {
				return nil
			}
		}

		data = string
	}

	//MARK: Comparable
	public static func <(left: Number, right: Number) -> Bool {
		if left.sign != right.sign { return left.sign == .negative }

		switch left.sign { // signs are equal
		case .positive:
			if left.data.count != right.data.count { return left.data.count < right.data.count }

			for (offset, char) in left.data.enumerated() {
				if char != right.data[offset] { return char < right.data[offset] }
			}

			return false // should be equal at this point

		case .negative:
			if left.data.count != right.data.count { return left.data.count < right.data.count }

			for (offset, char) in left.data.enumerated() {
				if char != right.data[offset] { return char > right.data[offset] }
			}

			return false // equal
		}
	}

	//MARK: Operations
	static func *(left: Number, right: Number) {}
	static func *=(left: inout Number, right: Number) {}
	static func +(left: Number, right: Number) -> Number {
		var newNumber = Number()

		if left.sign == right.sign {
			newNumber.sign = left.sign
			newNumber.data = {
				var newDataReversed = left.data.reversed()

				let rightReversed = right.data.reversed()
				for char in rightReversed {
				}

				return ""
			}()
		}
		else {
			return left.sign == .positive ? left - right : right - left
		}

		return newNumber
	}
	static func +=(left: inout Number, right: Number) {}
	static func -(left: Number, right: Number) -> Number {
		return Number()
	}
	static func -=(left: inout Number, right: Number) {}

}

fileprivate enum Sign {
	case positive
	case negative
}
