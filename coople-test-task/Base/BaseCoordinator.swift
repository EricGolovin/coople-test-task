//
//  BaseCoordinator.swift
//  coople-test-task
//
//  Created by Eric Golovin on 14/08/2023.
//

import UIKit

class BaseCoordinator {

    let serviceContainer: ServiceContainer
    let rootViewController: UINavigationController

    init(_ rootViewController: UINavigationController, serviceContainer: ServiceContainer) {
        self.rootViewController = rootViewController
        self.serviceContainer = serviceContainer
    }

    func start() {
        preconditionFailure("This method need to be overridden")
    }
}
