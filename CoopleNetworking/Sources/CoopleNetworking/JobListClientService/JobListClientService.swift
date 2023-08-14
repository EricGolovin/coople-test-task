//
//  JobListClientService.swift
//
//
//  Created by Eric Golovin on 14/08/2023.
//

import Foundation

public protocol JobListClientService {
    func getJobList() async throws -> JobList
}

public final actor JobListClientServiceImpl: JobListClientService {

    private let request = Request<JobList>(
        method: .get,
        path: "/ch/resources/api/work-assignments/public-jobs/list",
        query: [
            "pageNum": "0",
            "pageSize": "200"
        ]
    )
    private let remoteClientService: RemoteClientService

    public init(_ remoteClientService: RemoteClientService) {
        self.remoteClientService = remoteClientService
    }

    public func getJobList() async throws -> JobList {
        // Custom error handling can be done on this step
        let response = try await remoteClientService.send(request)
        return response.data
    }
}
