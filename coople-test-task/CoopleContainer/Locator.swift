//
//  Locator.swift
//  
//
//  Created by Eric Golovin on 14/08/2023.
//

final class Locator {

    private var services: [ObjectIdentifier: Any] = [:]

    func register<T>(_ service: T) {
        services[key(for: T.self)] = service
    }

    func resolve<T>() -> T? {
        return services[key(for: T.self)] as? T
    }

    private func key<T>(for type: T.Type) -> ObjectIdentifier {
        return ObjectIdentifier(T.self)
    }
}
