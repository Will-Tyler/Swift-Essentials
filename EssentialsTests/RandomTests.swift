//
//  RandomTests.swift
//  EssentialsTests
//
//  Created by Will Tyler on 5/19/18.
//  Copyright © 2018 Will Tyler. All rights reserved.
//

import XCTest


class RandomTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

	func testBool() {
		measure {
			var myBool: Bool

			repeat {
				myBool = Random.bool
			} while myBool != false

			repeat {
				myBool = Random.bool
			} while myBool != true
		}
	}

	func testInt() {
		measure {
			var myInt: Int

			switch MemoryLayout<Int>.size {
			case 4:
				repeat {
					myInt = Random.int
				} while !(myInt >= 0 && myInt <= Int32.max)

				repeat {
					myInt = Random.int
				} while !(myInt < 0 && myInt >= Int32.min)

			case 8:
				repeat {
					myInt = Random.int
				} while !(myInt >= 0 && myInt <= Int64.max)

				repeat {
					myInt = Random.int
				} while !(myInt < 0 && myInt >= Int64.min)
			default: fatalError("Could not recognize Int size.")
			}
		}
	}

	func testUInt() {
		measure {
			var myUInt: UInt

			switch MemoryLayout<UInt>.size {
			case 4:
				repeat {
					myUInt = Random.uint
				} while !(myUInt >= 0 && myUInt <= Int32.max)

				repeat {
					myUInt = Random.uint
				} while !(myUInt > Int32.max && myUInt <= UInt32.max)

			case 8:
				repeat {
					myUInt = Random.uint
				} while !(myUInt >= 0 && myUInt <= Int64.max)

				repeat {
					myUInt = Random.uint
				} while !(myUInt > Int64.max && myUInt <= UInt64.max)

			default: fatalError("Could not recognize UInt size.")
			}
		}
	}

	func testRandomFrom() {
		let mySmallRange = 1...10

		var myInt: Int
		for _ in 0..<256 {
			myInt = Random.from(mySmallRange)

			XCTAssert(mySmallRange.contains(myInt))
		}

		for number in mySmallRange {
			repeat {
				myInt = Random.from(mySmallRange)
			} while myInt != number
		}

		let myBigRange = 1...Int.max

		for _ in 0..<256 {
			myInt = Random.from(myBigRange)

			XCTAssert(myBigRange.contains(myInt))
		}

		let myNegativeRange = Int.min ..< -1

		for _ in 0..<256 {
			myInt = Random.from(myNegativeRange)

			XCTAssert(myNegativeRange.contains(myInt))
		}

		var myName: String
		let names = ["Will", "Robin", "Larry", "Aditya", "Josiah", "Raymond", "Bob"]

		for _ in 0..<256 {
			myName = Random.from(names)

			XCTAssert(names.contains(myName))
		}
	}

	func testCollectionOfOne() {
		XCTAssertEqual(Random.from(" "), " ")
	}

}




























