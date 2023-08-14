//
//  UITableView+Reuse.swift
//  coople-test-task
//
//  Created by Eric Golovin on 14/08/2023.
//

import UIKit

extension UITableView {

    func registeCell<T: UITableViewCell>(_ cell: T.Type) {
        register(cell, forCellReuseIdentifier: cell.identifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        // swiftlint:disable:next force_cast
        dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
}
