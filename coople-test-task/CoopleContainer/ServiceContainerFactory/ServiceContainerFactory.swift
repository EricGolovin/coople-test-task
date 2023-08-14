//
//  ServiceContainerFactory.swift
//
//
//  Created by Eric Golovin on 14/08/2023.
//

import Foundation

public final class ServiceContainerFactory {

    private let serviceContainer = ServiceContainerImpl()

    private lazy var dataStorageRegistration = DataStorageRegistration(serviceContainer)
    private lazy var networkClientRegistration = NetworkClientRegistration(serviceContainer)

    private let blocks: Set<ServiceContainerFactoryBlock>

    public init(_ blocks: ServiceContainerFactoryBlock...) {
        self.blocks = Set(blocks)
    }

    public func configureContainer() -> ServiceContainer {
        for block in blocks {
            switch block {
            case .dataStorage(let configuration):
                dataStorageRegistration.register(with: configuration)
            case .network(let configuration):
                networkClientRegistration.register(with: configuration)
            }
        }
        return serviceContainer
    }
}
