//
// Created by Will Tyler on 8/12/18.
//

import Foundation


public extension Character {

	var isDigit: Bool {
		get {
			return Characters.digits.contains(self)
		}
	}

	var isBit: Bool {
		get {
			return Characters.bits.contains(self)
		}
	}

}
