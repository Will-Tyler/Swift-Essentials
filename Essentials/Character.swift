//
// Created by Will Tyler on 8/12/18.
//

import Foundation


public extension Character {

	public var isDigit: Bool {
		get {
			let digits = Set("1234567890")

			return digits.contains(self)
		}
	}

	public var isBit: Bool {
		get {
			let bits = Set("01")

			return bits.contains(self)
		}
	}

}