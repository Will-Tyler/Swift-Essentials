//
//  RockPaperScissorsTests.swift
//  Essentials
//
//  Created by Will Tyler on 8/28/18.
//
//

import XCTest


class RockPaperScissorsTests: XCTestCase {

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

	private func assertGreaterThan(_ left: RockPaperScissors, _ right: RockPaperScissors) {
		XCTAssertGreaterThan(left, right)
	}
	private func assertNotGreaterThan(_ left: RockPaperScissors, _ right: RockPaperScissors) {
		XCTAssertLessThanOrEqual(left, right)
	}

	// TODO: Finish testing
	func testGreaterThan() {
		assertGreaterThan(.rock, .scissors)
		assertGreaterThan(.paper, .rock)
		assertGreaterThan(.scissors, .paper)

		assertNotGreaterThan(.rock, .rock)
		assertNotGreaterThan(.rock, .paper)

		assertNotGreaterThan(.paper, .paper)
		assertNotGreaterThan(.paper, .scissors)

		assertNotGreaterThan(.scissors, .scissors)
		assertNotGreaterThan(.scissors, .rock)
	}

}
