//
//  Completion.swift
//  EssentialsTests
//
//  Created by Will Tyler on 4/2/19.
//

import Foundation


/// Completion is a class that takes in a closure and checks that
/// the closure is executed exactly once using assert calls.
@dynamicCallable
public class Completion<T, E: Error> {

	private let closure: (Result<T, E>)->()
	private var didExecute = false

	public init(_ closure: @escaping (Result<T, E>)->()) {
		self.closure = closure
	}

	deinit {
		assert(didExecute)
	}

	public func complete(with result: Result<T, E>) {
		assert(!didExecute)

		if !didExecute {
			closure(result)
		}

		didExecute = true
	}

	func dynamicallyCall(withArguments arguments: [Result<T, E>]) {
		assert(arguments.count == 1)

		if let first = arguments.first {
			complete(with: first)
		}
	}

}
