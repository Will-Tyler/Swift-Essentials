//
//  RockPaperScissorsTests.swift
//  Essentials
//
//  Created by Will Tyler on 8/28/18.
//
//

import XCTest


class RockPaperScissorsTests: XCTestCase {

	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}

	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}

	private func assertEqual(_ left: RockPaperScissors, _ right: RockPaperScissors) {
		XCTAssertEqual(left, right)
	}
	private func assertNotEqual(_ left: RockPaperScissors, _ right: RockPaperScissors) {
		XCTAssertNotEqual(left, right)
	}

	func testEquatable() {
		assertEqual(.rock, .rock)
		assertEqual(.paper, .paper)
		assertEqual(.scissors, .scissors)

		assertNotEqual(.rock, .paper)
		assertNotEqual(.rock, .scissors)

		assertNotEqual(.paper, .rock)
		assertNotEqual(.paper, .scissors)

		assertNotEqual(.scissors, .rock)
		assertNotEqual(.scissors, .paper)
	}

	private func assertLessThan(_ left: RockPaperScissors, _ right: RockPaperScissors) {
		XCTAssertLessThan(left, right)
	}

	private func assertNotLessThan(_ left: RockPaperScissors, _ right: RockPaperScissors) {
		XCTAssertGreaterThanOrEqual(left, right)
	}

	func testLessThan() {
		assertLessThan(.rock, .paper)
		assertLessThan(.paper, .scissors)
		assertLessThan(.scissors, .rock)

		assertNotLessThan(.rock, .rock)
		assertNotLessThan(.rock, .scissors)

		assertNotLessThan(.paper, .paper)
		assertNotLessThan(.paper, .rock)

		assertNotLessThan(.scissors, .scissors)
		assertNotLessThan(.scissors, .paper)
	}

	// TODO: Finish testing
	func testGreaterThan() {}

}
