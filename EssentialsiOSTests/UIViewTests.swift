//
//  UIViewTests.swift
//  EssentialsiOSTests
//
//  Created by Will Tyler on 11/23/18.
//

import XCTest


class UIViewTests: XCTestCase {

	func testController() {
		let controller = UIViewController()
		let subview1 = UIView()
		let subview2 = UIView()
		let subview3 = UIView()
		let root = UIView()

		controller.view.addSubview(subview1)
		subview1.addSubview(subview2)
		subview2.addSubview(subview3)
		subview3.addSubview(root)

		XCTAssert(controller === root.controller)
	}

}
