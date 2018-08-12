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

}
