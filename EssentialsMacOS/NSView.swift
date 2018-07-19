//
//  NSView.swift
//  GroupMac
//
//  Created by Will Tyler on 7/11/18.
//  Copyright © 2018 Will Tyler. All rights reserved.
//

import Cocoa


public extension NSView {

	public var backColor: CGColor? {
		get {
			return layer?.backgroundColor
		}
		set {
			guard let newColor = newValue else { return }

			wantsLayer = true
			layer!.backgroundColor = newColor
		}
	}

	public func removeSubviews() {
		subviews.forEach({ $0.removeFromSuperview() })
	}
	
}
