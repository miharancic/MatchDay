//
//  ResultEntity.swift
//  MDKit
//
//  Created by Mihailo Rancic on 8. 12. 2025..
//

import SwiftData

@Model
public final class ResultEntity: @unchecked Sendable {
    public var home: Int
    public var away: Int
    
    public init(home: Int, away: Int) {
        self.home = home
        self.away = away
    }
}
