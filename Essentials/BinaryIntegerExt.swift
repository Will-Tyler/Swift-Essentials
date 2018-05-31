//
//  IntExt.swift
//  Essentials
//
//  Created by Will Tyler on 5/19/18.
//  Copyright © 2018 Will Tyler. All rights reserved.
//

import Foundation

public extension BinaryInteger {

	public static postfix func ++(number: inout Self) -> Self {
		defer {
			number += 1
		}

		return number
	}

	public static prefix func ++(number: inout Self) -> Self {
		number += 1

		return number
	}

	public static postfix func --(number: inout Self) -> Self {
		defer {
			number -= 1
		}

		return number
	}

	public static prefix func --(number: inout Self) -> Self {
		number -= 1

		return number
	}

}
