//
//  NetworkingServiceType.swift
//  MDKit
//
//  Created by Mihailo Rancic on 8. 12. 2025..
//

public protocol NetworkServiceType: Sendable {
    func send<T: APIRequest, R: Decodable>(_ request: T, responseType: R.Type) async throws -> R
}
