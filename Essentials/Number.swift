//
//  Number.swift
//  Essentials
//
//  Created by Will Tyler on 7/1/18.
//

import Foundation


public struct Number: Equatable {

	private var data: String
	private var sign: Sign

	public var value: String {
		get {
			var result = data

			if sign == .negative {
				result.insert("-", at: result.startIndex)
			}

			return data
		}
	}

	//MARK: Initializers
	public init() {
		data = "0"
		sign = .positive
	}
	public init<Type: BinaryInteger>(with value: Type) {
		data = "\(value)"

		if value < 0 {
			sign = .negative
		}
		else {
			sign = .positive
		}
	}
	public init?(from: String) {
		var string = from

		if string[0] == "-" {
			sign = .negative
			string.removeFirst()
		}
		else {
			sign = .positive
		}

		let digits: Set<Character> = Set("1234567890")
		for char in string {
			if !digits.contains(char) {
				return nil
			}
		}

		data = string
	}

	//MARK: Operations
	static func *(left: Number, right: Number) {}
	static func *=(left: inout Number, right: Number) {}
	static prefix func +(being: Number) {}
	static func +(left: Number, right: Number) {}
	static func +=(left: inout Number, right: Number) {}
	static func -(left: Number, right: Number) {}
	static func -=(left: inout Number, right: Number) {}

}

fileprivate enum Sign {
	case positive
	case negative
}
