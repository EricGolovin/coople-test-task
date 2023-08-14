//
//  RemoteClientServiceHolder.swift
//
//
//  Created by Eric Golovin on 14/08/2023.
//

import Foundation

public protocol RemoteClientServiceHolder {
    var remoteClientService: RemoteClientService { get }
}
