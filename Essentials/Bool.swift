//
//  Bool.swift
//  EssentialsTests
//
//  Created by Will Tyler on 6/22/18.
//

import Foundation


public extension Bool {

	/// Invert the value of this boolean.
	public mutating func toggle() {
		self = !self
	}
	
}
