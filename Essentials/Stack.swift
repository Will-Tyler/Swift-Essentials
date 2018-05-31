//
//  Stack.swift
//  Essentials
//
//  Created by Will Tyler on 5/19/18.
//  Copyright © 2018 Will Tyler. All rights reserved.
//

import Foundation

class Stack<Element> {

	private var elements: [Element] = [Element]()
	private var height: Int = 0

	private let max: Int?

	public var count: Int {
		get {
			return elements.count
		}
	}

	//MARK: Constructors
	init() {
		max = nil
	}
	init(maxCount: Int) {
		precondition(maxCount >= 0, "Cannot create Stack with negative maxCount.")
		self.max = maxCount
	}

	//MARK: Access
	public func push(_ new: Element...) {
		for element in new {
			if max != nil && height == max {
				elements.removeFirst()
			}
			else {
				height += 1
			}

			elements.append(element)
		}
	}

	public func pull(from index: Int) -> Element {
		defer {
			height -= 1
		}

		return elements.remove(at: index)
	}

	public func pop() -> Element {
		defer {
			height -= 1
		}

		return elements.removeLast()
	}

	public func peek() -> Element {
		return elements.last!
	}

	public subscript(index: Int) -> Element {
		get {
			return elements[index]
		}
	}

}
