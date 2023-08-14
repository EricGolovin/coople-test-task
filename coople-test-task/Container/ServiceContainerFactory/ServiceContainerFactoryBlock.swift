//
//  ServiceContainerFactoryBlock.swift
//
//
//  Created by Eric Golovin on 14/08/2023.
//

import Foundation

public enum ServiceContainerFactoryBlock: Hashable {
    case dataStorage(DataStorageRegistrationConfiguration)
    case network(NetworkAccessConfiguration)
}
