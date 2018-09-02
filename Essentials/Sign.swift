//
//  Sign.swift
//  EssentialsTests
//
//  Created by Will Tyler on 9/1/18.
//

import Foundation


public enum Sign: Comparable {

	case positive
	case zero
	case negative

	public mutating func toggle() {
		switch self {
		case .positive:
			self = .negative
		case .negative:
			self = .positive
		case.zero:
			break
		}
	}

	public static func <(left: Sign, right: Sign) -> Bool {
		switch left {
		case positive:
			return false

		case negative:
			return left != right

		case zero:
			return right == positive
		}
	}

}
