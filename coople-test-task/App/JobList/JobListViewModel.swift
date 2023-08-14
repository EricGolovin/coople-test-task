//
//  JobListViewModel.swift
//  coople-test-task
//
//  Created by Eric Golovin on 14/08/2023.
//  
//

import Foundation
import Combine
import CoopleNetworking

final class JobListViewModel: BaseViewModel {

    typealias Holder = JobListClientServiceHolder
    typealias PathHandler = (JobListCoordinator.Path) -> Void

    // MARK: Publishers

    @Published private(set) var jobItems: [JobList.Item] = []

    // MARK: Dependencies

    private let jobListClientService: JobListClientService

    // MARK: Private properties

    private let pathHandler: PathHandler

    // MARK: Initialisers

    init(_ serviceContainer: Holder, pathHandler: @escaping PathHandler) {
        jobListClientService = serviceContainer.jobListClientService
        self.pathHandler = pathHandler
    }

    // MARK: Public methods

    func didLoad() {
        refresh()
    }

    func refresh() {
        Task { [weak self] in
            guard let self else { return }
            do {
                self.jobItems = try await jobListClientService.getJobList().items
            } catch {
                self.handleError(error)
            }
        }
    }

    func didSelectJobItem(_ jobItem: JobList.Item) {
        // Navigate to details screen
        // pathHandler(.jobDetail(jobItem))
    }

    // MARK: Private methods

    private func handleError(_ error: Error) {
        // Present alert if needed
    }

}

// MARK: - JobCellData conformance

extension JobList.Item: JobCellData {
    var assignmentName: String { workAssignmentName }
    var addressStreet: String { jobLocation.addressStreet }
    var locationZip: String { jobLocation.zip }
    var city: String { jobLocation.city }
}
