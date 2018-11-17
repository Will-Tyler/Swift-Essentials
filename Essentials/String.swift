//
//  StringExt.swift
//  Essentials
//
//  Created by Will Tyler on 5/19/18.
//  Copyright © 2018 Will Tyler. All rights reserved.
//

import Foundation


public extension String {

	static let digits = "0123456789"
	static let lowercaseLetters = "abcdefghijklmnopqrstuvwxyz"
	static let uppercaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

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

		guard count >= minCount else {
			return false
		}

		let validTokens: Set<Character> = {
			let possibleTokens = String.digits + String.lowercaseLetters
			let cutIndex = possibleTokens.index(startIndex, offsetBy: Int(radix))
			let tokensRange = possibleTokens.startIndex..<cutIndex
			let tokensForRadix = possibleTokens[tokensRange]

			return Set(tokensForRadix)
		}()

		for char in self[start...] {
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

	var isValidEmail: Bool {
		get {
			let pattern = "\\A(?=[a-z0-9@.!#$%&'*+/=?^_`{|}~-]{6,254}\\z)(?=[a-z0-9.!#$%&'*+/=?^_`{|}~-]{1,64}@)[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:(?=[a-z0-9-]{1,63}\\.)[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+(?=[a-z0-9-]{1,63}\\z)[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\z"
			let regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)

			return regex.numberOfMatches(in: self, range: NSRange(location: 0, length: count)) > 0
		}
	}

}
