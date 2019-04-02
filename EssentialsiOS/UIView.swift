//
// Created by Will Tyler on 8/24/18.
//

import UIKit


public extension UIView {

	func removeSubviews() {
		subviews.forEach({ $0.removeFromSuperview() })
	}

	var controller: UIViewController? {
		get {
			if let controller = next as? UIViewController {
				return controller
			}
			else if let view = next as? UIView {
				return view.controller
			}
			else {
				return nil
			}
		}
	}

}
