//
//  CompetitionEntity.swift
//  MDKit
//
//  Created by Mihailo Rancic on 8. 12. 2025..
//

import SwiftData

@Model
public final class CompetitionEntity: @unchecked Sendable {
    @Attribute(.unique)
    public var id: Int
    public var sportId: Int
    public var sport: SportEntity?
    public var name: String
    public var sportIconUrl: String
    
    public init(id: Int, sportId: Int, sport: SportEntity?, name: String, sportIconUrl: String) {
        self.id = id
        self.sportId = sportId
        self.sport = sport
        self.name = name
        self.sportIconUrl = sportIconUrl
    }
}
