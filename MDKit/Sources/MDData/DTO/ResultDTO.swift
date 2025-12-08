//
//  ResultDTO.swift
//  MDKit
//
//  Created by Mihailo Rancic on 8. 12. 2025..
//

struct ResultDTO: Codable, Sendable {
    let home: Int
    let away: Int
    
    init(home: Int, away: Int) {
        self.home = home
        self.away = away
    }
}
