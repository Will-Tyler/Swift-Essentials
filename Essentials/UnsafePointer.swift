//
//  UnsafePointer.swift
//  EssentialsTests
//
//  Created by Will Tyler on 8/12/18.
//

import Foundation


prefix operator *

public extension UnsafePointer {

	public static prefix func *(pointer: UnsafePointer) -> Pointee {
		return pointer.pointee
	}

}
