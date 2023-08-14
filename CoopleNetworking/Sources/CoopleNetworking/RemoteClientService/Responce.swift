//
//  Response.swift
//
//
//  Created by Eric Golovin on 14/08/2023.
//

import Foundation

public struct Response<T: Decodable>: Decodable {

    let data: T
    let status: Int
    let errorCode: String
    let errorID: Int
    let error: Bool

    enum CodingKeys: String, CodingKey {
        case status, data, errorCode
        case errorID = "errorId"
        case error
    }
}
