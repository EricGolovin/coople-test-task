//
//  UIView+Identifiers.swift
//  coople-test-task
//
//  Created by Eric Golovin on 14/08/2023.
//

import UIKit

extension UIView {

    static var identifier: String {
        String(describing: Self.self)
    }
}
