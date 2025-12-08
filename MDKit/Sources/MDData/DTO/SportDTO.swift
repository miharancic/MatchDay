//
//  SportDTO.swift
//  MDKit
//
//  Created by Mihailo Rancic on 8. 12. 2025..
//

struct SportDTO: Codable, Sendable {
    let id: Int
    let name: String
    let sportIconUrl: String?
    
    init(id: Int, name: String, sportIconUrl: String?) {
        self.id = id
        self.name = name
        self.sportIconUrl = sportIconUrl
    }
}
