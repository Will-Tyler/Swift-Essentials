//
//  BoolTests.swift
//  EssentialsTests
//
//  Created by Will Tyler on 6/22/18.
//

import XCTest

class BoolTests: XCTestCase {

	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}

	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}

	func testToggle() {
		var myBool = false

		myBool.toggle()

		XCTAssertEqual(myBool, true)

		myBool.toggle()

		XCTAssertEqual(myBool, false)

		myBool.toggle()

		XCTAssertEqual(myBool, true)

		myBool.toggle()

		XCTAssertEqual(myBool, false)
	}

}
