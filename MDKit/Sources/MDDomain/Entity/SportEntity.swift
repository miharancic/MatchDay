//
//  SportEntity.swift
//  MDKit
//
//  Created by Mihailo Rancic on 8. 12. 2025..
//

import SwiftData

@Model
public final class SportEntity: @unchecked Sendable {
    @Attribute(.unique)
    public var id: Int
    public var name: String
    public var sportIconUrl: String?
    
    public init(id: Int, name: String, sportIconUrl: String?) {
        self.id = id
        self.name = name
        self.sportIconUrl = sportIconUrl
    }
}
