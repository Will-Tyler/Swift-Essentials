//
//  UIColor.swift
//  EssentialsiOS
//
//  Created by Will Tyler on 11/15/18.
//

import UIKit


extension UIColor {

	convenience init(red: Int, green: Int, blue: Int) {
		self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
	}
	
}
