//
//  Bool.swift
//  EssentialsTests
//
//  Created by Will Tyler on 6/22/18.
//

import Foundation


public extension Bool {

	public mutating func toggle() {
		if self {
			self = false
		}
		else {
			self = true
		}
	}
	
}
