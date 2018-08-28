//
//  StringExt.swift
//  Essentials
//
//  Created by Will Tyler on 5/19/18.
//  Copyright © 2018 Will Tyler. All rights reserved.
//

import Foundation


public extension String {

	/// Return the character at the specified index.
	public subscript(i: Int) -> Character {
		return self[index(startIndex, offsetBy: i)]
	}

	/// Return whether this String only contains the digits 0-9, possibly with a leading negative sign.
	var isDecimalNumber: Bool {
		get {
			var copy = self

			if copy.isEmpty {
				return false
			}
			else if copy.first == "-" {
				copy.removeFirst()

				if copy.isEmpty {
					return false
				}
			}

			for char in copy {
				if !char.isDigit {
					return false
				}
			}

			return true
		}
	}
	/// Return whether this String only contains the digits 0-9.
	var isPositiveDecimalNumber: Bool {
		get {
			if isEmpty {
				return false
			}

			for char in self {
				if !char.isDigit {
					return false
				}
			}

			return true
		}
	}

	// TODO: Fix deprecations
	/// Check if this String is a valid representation of a Number.
	func isValidNumber(forRadix radix: UInt = 10) -> Bool {
		precondition(radix >= Number.minRadix && radix <= Number.maxRadix, "The radix is limited inclusively to values between \(Number.minRadix) and \(Number.maxRadix)")

		guard !isEmpty else {
			return false
		}

		let start: String.Index
		let minCount: Int

		if first! == "-" {
			start = index(startIndex, offsetBy: 1)
			minCount = 2
		}
		else {
			start = startIndex
			minCount = 1
		}

		if count < minCount {
			return false
		}

		let validTokens: Set<Character> = {
			let possibleTokens = "0123456789abcdefghijklmnopqrstuvwxyz"
			let cutIndex = possibleTokens.index(startIndex, offsetBy: Int(radix))
			let tokensForRadix: String = possibleTokens.substring(to: cutIndex)
			var tokens = Set(tokensForRadix)

			return tokens
		}()

		for char in substring(from: start) {
			if !validTokens.contains(char) {
				return false
			}
		}

		return true
	}

	/// Remove any leading zeroes in this String if the String is a decimal number.
	mutating func removeLeadingZeroes() {
		if isDecimalNumber {
			let start: String.Index
			let minCount: Int

			if first! == "-" {
				start = index(startIndex, offsetBy: 1)
				minCount = 2
			}
			else {
				start = startIndex
				minCount = 1
			}

			// One zero is acceptable.
			while count > minCount, self[start] == "0" {
				remove(at: start)
			}
		}
	}

}
