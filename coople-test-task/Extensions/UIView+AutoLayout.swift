//
//  UIView+AutoLayout.swift
//  coople-test-task
//
//  Created by Eric Golovin on 14/08/2023.
//

import UIKit

extension UIView {

    func pin(toEdgesOf view: UIView, constant: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: constant.top),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant.bottom),
            leftAnchor.constraint(equalTo: view.leftAnchor, constant: constant.left),
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: -constant.right)
        ])
    }

    func pinSafely(toEdgesOf view: UIView, constant: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constant.top),
            bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -constant.bottom),
            leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: constant.left),
            rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -constant.right)
        ])
    }
}
