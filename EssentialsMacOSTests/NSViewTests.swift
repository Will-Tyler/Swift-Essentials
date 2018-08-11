//
//  NSViewTests.swift
//  EssentialsMacOSTests
//
//  Created by Will Tyler on 8/11/18.
//

import XCTest


class NSViewTests: XCTestCase {

	private var view: NSView!

	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.

		view = NSView()
	}

	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}

	func testBackColor() {
		view.backColor = NSColor.blue.cgColor

		XCTAssertEqual(view.backColor, NSColor.blue.cgColor)

		view.backColor = nil

		XCTAssertNil(view.backColor)

		view.backColor = .black

		XCTAssertEqual(CGColor.black, view.backColor)
	}

	func testRemoveSubviews() {
		view.removeSubviews()

		XCTAssert(view.subviews.isEmpty)

		for _ in 0..<5 {
			view.addSubview(NSView())
		}

		XCTAssertEqual(view.subviews.count, 5)

		view.removeSubviews()

		XCTAssert(view.subviews.isEmpty)
	}

	func testRemoveConstraints() {
		let subview = NSView()

		view.addSubview(subview)

		subview.translatesAutoresizingMaskIntoConstraints = false
		subview.topAnchor.constraint(equalTo: view.topAnchor, constant: 4).isActive = true
		subview.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 4).isActive = true
		subview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -4).isActive = true
		subview.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -4).isActive = true

		// The view containing view should be maintaining all constraints.
		XCTAssertEqual(view.constraints.count, 4)

		view.removeConstraints()

		XCTAssert(view.constraints.isEmpty)

		view.removeSubviews()
	}

	func testDeactivateAndRemoveConstraints() {
		let subview = NSView()

		view.addSubview(subview)

		subview.translatesAutoresizingMaskIntoConstraints = false
		subview.topAnchor.constraint(equalTo: view.topAnchor, constant: 4).isActive = true
		subview.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 4).isActive = true
		subview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -4).isActive = true
		subview.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -4).isActive = true

		let constraints = view.constraints // view manages constraints

		XCTAssertEqual(constraints.count, 4)

		view.deactivateAndRemoveConstraints()

		XCTAssert(view.constraints.isEmpty)

		XCTAssertEqual(constraints.count, 4) // make sure our array still contains the constraints

		constraints.forEach({ XCTAssertFalse($0.isActive) })
	}

}
