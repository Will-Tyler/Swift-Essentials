//
// Created by Will Tyler on 8/31/18.
//

import Foundation


public protocol Incrementable {

	/// Increment the value, and then return it.
	@discardableResult
	prefix static func ++(item: inout Self) -> Self

	/// Return the item, and then increment the value.
	@discardableResult
	postfix static func ++(item: inout Self) -> Self

}