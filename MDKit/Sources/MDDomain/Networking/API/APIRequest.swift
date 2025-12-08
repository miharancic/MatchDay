//
//  APIRequest.swift
//  MDKit
//
//  Created by Mihailo Rancic on 8. 12. 2025..
//

import Foundation

public enum API {
    public static let baseURL = URL(string: "https://take-home-api-7m87.onrender.com/api")!
}

public protocol APIRequest {
    var endpoint: String { get }
    var method: String { get }
}
