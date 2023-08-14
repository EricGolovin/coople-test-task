//
//  RemoteClientService.swift
//
//
//  Created by Eric Golovin on 14/08/2023.
//

import Foundation

public protocol RemoteClientService {
    func send<T>(_ request: Request<T>) async throws -> Response<T> where T: Decodable
}

enum RemoteClientError: Error, LocalizedError {
    case undefinedStatusCode(Int)

    public var errorDescription: String? {
        switch self {
        case .undefinedStatusCode(let statusCode):
            return "Response status code was undefined: \(statusCode)."
        }
    }
}

public struct RemoteClientServiceConfiguration {
    let baseURL: URL
    let sessionConfiguration: URLSessionConfiguration
    let decoder: JSONDecoder
    let encoder: JSONEncoder

    public init(
        baseURL: URL,
        sessionConfiguration: URLSessionConfiguration = .default,
        decoder: JSONDecoder = JSONDecoder(),
        encoder: JSONEncoder = JSONEncoder()
    ) {
        self.baseURL = baseURL
        self.sessionConfiguration = sessionConfiguration
        self.decoder = decoder
        self.encoder = encoder
    }
}

public final actor RemoteClientServiceImpl: RemoteClientService {

    private let configuration: RemoteClientServiceConfiguration
    public nonisolated let session: URLSession
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder

    public init(_ configuration: RemoteClientServiceConfiguration) {
        self.configuration = configuration
        self.session = URLSession(configuration: configuration.sessionConfiguration)
        self.decoder = configuration.decoder
        self.encoder = configuration.encoder
    }

    public func send<T: Decodable>(_ request: Request<T>) async throws -> Response<T> {
        try await send(request, decode)
    }

    private func send<T>(_ request: Request<T>,
                         _ decode: (Data) async throws -> Response<T>) async throws -> Response<T> {
        let urlRequest = try await makeURLRequest(for: request)
        let (data, response) = try await send(urlRequest)
        try validate(response: response, data: data)
        return try await decode(data)
    }

    private func send(_ request: URLRequest) async throws -> (Data, URLResponse) {
        try await session.data(for: request, delegate: nil)
    }

    private func validate(response: URLResponse, data: Data) throws {
        guard let httpResponse = response as? HTTPURLResponse else { return }
        if !(200..<300).contains(httpResponse.statusCode) {
            throw RemoteClientError.undefinedStatusCode(httpResponse.statusCode)
        }
    }

    private func makeURLRequest<T>(for request: Request<T>) async throws -> URLRequest {
        let url = try makeURL(for: request)
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpMethod = request.method.rawValue
        if let body = request.body {
            urlRequest.httpBody = try await encode(body)
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil &&
                session.configuration.httpAdditionalHeaders?["Content-Type"] == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        }
        if urlRequest.value(forHTTPHeaderField: "Accept") == nil &&
            session.configuration.httpAdditionalHeaders?["Accept"] == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        }
        return urlRequest
    }

    private func makeURL<T>(for request: Request<T>) throws -> URL {
        func constructURL() -> URL? {
            guard let url = request.url else { return nil }
            return url.scheme == nil ? configuration.baseURL.appendingPathComponent(url.absoluteString) : url
        }
        guard let url = constructURL(),
              var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw URLError(.badURL)
        }
        if let query = request.query, !query.isEmpty {
            components.queryItems = query.map(URLQueryItem.init)
        }
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        return url
    }

    private func decode<T: Decodable>(_ data: Data) async throws -> T {
        if T.self == Data.self {
            return data as! T // swiftlint:disable:this force_cast
        } else if T.self == String.self {
            guard let string = String(data: data, encoding: .utf8) else {
                throw URLError(.badServerResponse)
            }
            return string as! T // swiftlint:disable:this force_cast
        }
        return try await Task.detached {
            try self.decoder.decode(T.self, from: data)
        }.value
    }

    private func encode(_ value: Encodable) async throws -> Data? {
        if let string = value as? String {
            return string.data(using: .utf8)
        }
        return try await Task.detached {
            try self.encoder.encode(value.self)
        }.value
    }
}
