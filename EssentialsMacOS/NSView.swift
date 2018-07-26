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
			if wantsLayer {
				return layer?.backgroundColor
			}
			else { return nil }
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

	public func removeConstraints() {
		removeConstraints(constraints)
	}

	@available(OSXApplicationExtension 10.10, *)
	public func deactivateAndRemoveConstraints() {
		constraints.forEach({ $0.isActive = false })

		removeConstraints()
	}

}
