//
//  CompetitionDTO.swift
//  MDKit
//
//  Created by Mihailo Rancic on 8. 12. 2025..
//

struct CompetitionDTO: Codable, Sendable {
    let id: Int
    let sportId: Int
    let name: String
    let competitionIconUrl: String
    
    init(id: Int, sportId: Int, name: String, competitionIconUrl: String) {
        self.id = id
        self.sportId = sportId
        self.name = name
        self.competitionIconUrl = competitionIconUrl
    }
}
