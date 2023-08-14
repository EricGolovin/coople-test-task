//
//  NetworkClientRegistration.swift
//
//
//  Created by Eric Golovin on 14/08/2023.
//

import Foundation
import CoopleNetworking

public struct NetworkAccessConfiguration: Hashable {
    let baseURL: URL

    public init(baseURL: URL) {
        self.baseURL = baseURL
    }
}

final class NetworkClientRegistration {

    private let serviceContainer: ServiceContainerImpl

    init(_ serviceContainer: ServiceContainerImpl) {
        self.serviceContainer = serviceContainer
    }

    func register(with configuration: NetworkAccessConfiguration) {
        let remoteClientServiceConfiguration = RemoteClientServiceConfiguration(baseURL: configuration.baseURL)
        serviceContainer.registerRemoteClientService(with: remoteClientServiceConfiguration)
        serviceContainer.registerJobListClientService()
    }
}
