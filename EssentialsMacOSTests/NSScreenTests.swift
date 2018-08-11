//
//  NSScreenTests.swift
//  Essentials
//
//  Created by Will Tyler on 8/10/18.
//
//

import XCTest
//import Cocoa


class NSScreenTests: XCTestCase {

	private var screen: NSScreen!

	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.

		screen = NSScreen.main
	}

	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}

	func testSize() {
		let frame = screen.frame
		let expectedSize = NSSize(width: frame.width, height: frame.height)

		XCTAssertEqual(screen.size, expectedSize)
	}

}
