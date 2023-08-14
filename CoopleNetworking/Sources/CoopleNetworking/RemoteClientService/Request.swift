//
//  Request.swift
//
//
//  Created by Eric Golovin on 14/08/2023.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

public struct Request<Response> {

    let method: HTTPMethod
    let url: URL?
    let query: [String: String]?
    let headers: [String: String]?
    let body: Encodable?

    init(
        method: HTTPMethod,
        path: String,
        query: [String: String]? = nil,
        headers: [String: String]? = nil,
        body: Encodable? = nil
    ) {
        self.method = method
        self.url = URL(string: path.isEmpty ? "/" : path)
        self.query = query
        self.headers = headers
        self.body = body
    }
}
