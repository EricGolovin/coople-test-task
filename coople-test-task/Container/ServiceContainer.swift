//
//  ServiceContainer.swift
//  
//
//  Created by Eric Golovin on 14/08/2023.
//

import Foundation
import CoopleNetworking

public protocol ServiceContainer: RemoteClientServiceHolder, JobListClientServiceHolder {

}

public class ServiceContainerImpl {

    private let locator = Locator()

    public func registerRemoteClientService(with configuration: RemoteClientServiceConfiguration) {
        let service: RemoteClientService = RemoteClientServiceImpl(configuration)
        locator.register(service)
    }

    public func registerJobListClientService() {
        let service: JobListClientService = JobListClientServiceImpl(remoteClientService)
        locator.register(service)
    }
}

// MARK: - ServiceContainer conformance

extension ServiceContainerImpl: ServiceContainer {

    public var remoteClientService: RemoteClientService {
        guard let service: RemoteClientService = locator.resolve() else {
            fatalError(errorMessage(for: RemoteClientService.self))
        }
        return service
    }

    public var jobListClientService: JobListClientService {
        guard let service: JobListClientService = locator.resolve() else {
            fatalError(errorMessage(for: JobListClientService.self))
        }
        return service
    }

    private func errorMessage<T>(for object: T) -> String {
        "Couldn't resolve \(String(describing: object.self))."
    }
}
