//
//  NetworkingService.swift
//  MDKit
//
//  Created by Mihailo Rancic on 8. 12. 2025..
//

import Foundation
import MDDomain

public final class NetworkService: NetworkServiceType {
    private let session: URLSession
    private let baseURL: URL
    
    public init(baseURL: URL = API.baseURL, session: URLSession = URLSession.shared) {
        self.baseURL = baseURL
        self.session = session
    }
    
    public enum NetworkError: Error {
        case invalidURL
        case invalidResponse
        case statusCode(Int)
        case decoding(Error)
        case other(Error)
    }
    
    public func send<T: APIRequest, R: Decodable>(_ request: T, responseType: R.Type) async throws -> R {
        try await self.request(request.endpoint, method: request.method, responseType: responseType)
    }
    
    private func request<T: Decodable>(_ endpoint: String, method: String, responseType: T.Type) async throws -> T {
        var request = URLRequest(url: baseURL.appending(path: endpoint))
        request.httpMethod = method
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.statusCode(httpResponse.statusCode)
        }
        
        let decoder = JSONDecoder()
        
        do {
            print("[NetworkService] \(request.description) response: \(String(decoding: data, as: UTF8.self))")
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decoding(error)
        }
    }
}
