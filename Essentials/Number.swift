//
//  Number.swift
//  Essentials
//
//  Created by Will Tyler on 7/1/18.
//

import Foundation


public struct Number: Comparable {

	private var data: String
	private var isPositive: Bool
	private var isNegative: Bool {
		get { return !isPositive }
		set { isPositive = !newValue }
	}

	public var value: String {
		get {
			var result = data

			if isNegative {
				result.insert("-", at: result.startIndex)
			}

			return result
		}
	}
	public var magnitude: Number {
		get { return Number(from: data)! }
	}

	//MARK: Initializers
	public init() {
		data = "0"
		isPositive = true
	}
	public init<Type: BinaryInteger>(with value: Type) {
		self.init(from: "\(value)")!
	}
	public init?(from: String) {
		var string = from

		if string.isEmpty { return nil }

		if string.first! == "-" {
			isPositive = false
			string.removeFirst()
			if string.isEmpty { return nil }
		}
		else {
			isPositive = true
		}

		let digits: Set<Character> = Set("1234567890")
		for char in string {
			if !digits.contains(char) { return nil }
		}

		data = string
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

	//MARK: Operations
	static func *(left: Number, right: Number) {}
	static func *=(left: inout Number, right: Number) {}
	static func +(left: Number, right: Number) -> Number {
		var newNumber = Number()

		if left.isPositive == right.isPositive {
			newNumber.isPositive = left.isPositive
			newNumber.data = {
				var newDataReversed = left.data.reversed()

				let rightReversed = right.data.reversed()
				for char in rightReversed {
				}

				return ""
			}()
		}
		else {
			return left.isPositive ? left - right : right - left
		}

		return newNumber
	}
	static func +=(left: inout Number, right: Number) {}
	static func -(left: Number, right: Number) -> Number {
		return Number()
	}
	static func -=(left: inout Number, right: Number) {}

}
