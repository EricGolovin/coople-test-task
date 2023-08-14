//
//  JobListClientServiceHolder.swift
//
//
//  Created by Eric Golovin on 14/08/2023.
//

import Foundation

public protocol JobListClientServiceHolder {
    var jobListClientService: JobListClientService { get }
}
