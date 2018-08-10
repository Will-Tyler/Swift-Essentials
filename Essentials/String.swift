//
//  StringExt.swift
//  Essentials
//
//  Created by Will Tyler on 5/19/18.
//  Copyright © 2018 Will Tyler. All rights reserved.
//

import Foundation


public extension String {

	/// Return the character at the specified index.
	public subscript(i: Int) -> Character {
		return self[index(startIndex, offsetBy: i)]
	}

}
