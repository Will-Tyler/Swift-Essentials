//
//  StackTests.swift
//  EssentialsTests
//
//  Created by Will Tyler on 5/19/18.
//  Copyright © 2018 Will Tyler. All rights reserved.
//

import XCTest

class StackTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
	}

	func testStackPushPop() {
		let stack: Stack<Int> = Stack()

		stack.push(1, 2, 3, 4, 5)

		XCTAssertEqual(stack.pop(), 5)
		XCTAssertEqual(stack.pop(), 4)
		XCTAssertEqual(stack.pop(), 3)
		XCTAssertEqual(stack.pop(), 2)
		XCTAssertEqual(stack.pop(), 1)
	}

	func testStackPushPopWithMax() {
		let stackWithMax: Stack<Int> = Stack(maxCount: 5)

		stackWithMax.push(1, 2, 3, 4, 5, 6)

		XCTAssertEqual(stackWithMax.pop(), 6)
		XCTAssertEqual(stackWithMax.pop(), 5)
		XCTAssertEqual(stackWithMax.pop(), 4)
		XCTAssertEqual(stackWithMax.pop(), 3)
		XCTAssertEqual(stackWithMax.pop(), 2)
	}

	func testStackPeek() {
		let stack: Stack<Int> = Stack<Int>()

		stack.push(1)

		XCTAssertEqual(stack.peek(), 1)

		stack.push(2, 3, 4, 5)

		XCTAssertEqual(stack.peek(), 5)
		XCTAssertEqual(stack.peek(), 5)
	}

	func testStackSubscript() {
		let stack: Stack<Int> = Stack<Int>()

		stack.push(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)

		XCTAssertEqual(stack[4], 5)
		XCTAssertEqual(stack[0], 1)
		XCTAssertEqual(stack[9], 10)
	}

	func testStackPull() {
		let stack: Stack<Int> = Stack<Int>()

		stack.push(1, 2, 3)

		XCTAssertEqual(stack.pull(from: 1), 2)

		XCTAssertEqual(stack.pop(), 3)
		XCTAssertEqual(stack.pop(), 1)
	}

	func testStackCount() {
		let stack: Stack<Int> = Stack<Int>()

		stack.push(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)

		XCTAssertEqual(stack.count, 10)

		XCTAssertEqual(stack.pop(), 10)

		XCTAssertEqual(stack.count, 9)

		XCTAssertEqual(stack.pull(from: 3), 4)

		XCTAssertEqual(stack.count, 8)
		XCTAssertEqual(stack.count, 8)
	}

}
