//
//  JobListCoordinator.swift
//  coople-test-task
//
//  Created by Eric Golovin on 14/08/2023.
//  
//

import UIKit
import CoopleNetworking

final class JobListCoordinator: BaseCoordinator {

    enum Path {
        case jobDetail(JobList.Item)
    }

    override func start() {
        let viewModel = JobListViewModel(serviceContainer) { path in
            switch path {
            case .jobDetail(let jobData):
                self.startJobDetail(with: jobData)
            }
        }
        let viewController = JobListViewController(viewModel: viewModel)
        rootViewController.pushViewController(viewController, animated: true)
    }

    private func startJobDetail(with jobItem: JobList.Item) {

    }
}
