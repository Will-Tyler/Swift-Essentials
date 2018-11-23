//
//  NSView.swift
//  GroupMac
//
//  Created by Will Tyler on 7/11/18.
//  Copyright © 2018 Will Tyler. All rights reserved.
//

import Cocoa


public extension NSView {

	/// The background color of this view. It is better to use backgroundColor, if available.
	public var backColor: CGColor? {
		get {
			return layer?.backgroundColor
		}
		set {
			wantsLayer = true
			layer!.backgroundColor = newValue
		}
	}

	/// Remove all subviews from this view.
	public func removeSubviews() {
		subviews.forEach({ $0.removeFromSuperview() })
	}

	/// Remove all constraints from this view.
	public func removeConstraints() {
		removeConstraints(constraints)
	}

	/// Deactivate and remove all constraints from this view.
	@available(OSX 10.10, *)
	@available(OSXApplicationExtension 10.10, *)
	public func deactivateAndRemoveConstraints() {
		constraints.forEach({ $0.deactivate() })
		removeConstraints()
	}

}
