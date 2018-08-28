//
// Created by Will Tyler on 8/28/18.
//

import Foundation


/*
The goal of this enum is to represent an interesting situation
in which the range of possible values is not linear, and instead
loops around.
*/
public enum RockPaperScissors: Comparable {

	case rock
	case paper
	case scissors

	public static func <(left: RockPaperScissors, right: RockPaperScissors) -> Bool {
		switch left {
		case .rock:
			return right == .paper

		case .paper:
			return right == .scissors

		case .scissors:
			return right == .rock
		}
	}

}