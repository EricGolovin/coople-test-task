//
//  AppCoordinator.swift
//  coople-test-task
//
//  Created by Eric Golovin on 14/08/2023.
//

import UIKit

class AppCoordinator {

    private let window: UIWindow
    private let serviceContainer: ServiceContainer
    private let rootViewController = UINavigationController()

    init(window: UIWindow, serviceContainer: ServiceContainer) {
        self.window = window
        self.serviceContainer = serviceContainer
    }

    func start() {
        JobListCoordinator(rootViewController, serviceContainer: serviceContainer).start()
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
