//
//  SignTests.swift
//  Essentials
//
//  Created by Will Tyler on 9/1/18.
//
//

import XCTest


class SignTests: XCTestCase {

	private func assert(_ left: Sign, equals right: Sign) {
		XCTAssertEqual(left, right)
	}
	private func assertNot(_ left: Sign, equals right: Sign) {
		XCTAssertNotEqual(left, right)
	}

	func testEqual() {
		assert(.positive, equals: .positive)
		assert(.zero, equals: .zero)
		assert(.negative, equals: .negative)

		assertNot(.positive, equals: .zero)
		assertNot(.positive, equals: .negative)

		assertNot(.zero, equals: .positive)
		assertNot(.zero, equals: .negative)

		assertNot(.negative, equals: .positive)
		assertNot(.negative, equals: .zero)
	}

	private func assert(_ left: Sign, lessThan right: Sign) {
		XCTAssertLessThan(left, right)
	}
	private func assertNot(_ left: Sign, lessThan right: Sign) {
		XCTAssertGreaterThanOrEqual(left, right)
	}

	func testLessThan() {
		assert(.zero, lessThan: .positive)
		assert(.negative, lessThan: .zero)
		assert(.negative, lessThan: .positive)

		assertNot(.positive, lessThan: .positive)
		assertNot(.positive, lessThan: .zero)
		assertNot(.positive, lessThan: .negative)

		assertNot(.zero, lessThan: .zero)
		assertNot(.zero, lessThan: .negative)

		assertNot(.negative, lessThan: .negative)
	}

}
