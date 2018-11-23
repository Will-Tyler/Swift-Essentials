//
// Created by Will Tyler on 8/12/18.
//

import Foundation


public extension Character {

	public var isDigit: Bool {
		get {
			return Characters.digits.contains(self)
		}
	}

	public var isBit: Bool {
		get {
			return Characters.bits.contains(self)
		}
	}

}
