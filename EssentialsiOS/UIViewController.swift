//
// Created by Will Tyler on 8/26/18.
// Copyright (c) 2018 Will Tyler. All rights reserved.
//

import UIKit


public extension UIViewController {

	public func alertUser(title: String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let dismiss = UIAlertAction(title: "Dismiss", style: .default)

		alert.addAction(dismiss)
		present(alert, animated: true)
	}

}
