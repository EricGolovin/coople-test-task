//
//  DataStorageRegistration.swift
//
//
//  Created by Eric Golovin on 14/08/2023.
//

import Foundation

public struct DataStorageRegistrationConfiguration: Hashable {
    public init() { }
}

final class DataStorageRegistration {

    private let serviceContainer: ServiceContainerImpl

    init(_ serviceContainer: ServiceContainerImpl) {
        self.serviceContainer = serviceContainer
    }

    func register(with configuration: DataStorageRegistrationConfiguration) { }
}
