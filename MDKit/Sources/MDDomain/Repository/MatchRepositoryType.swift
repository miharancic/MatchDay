//
//  MatchRepositoryType.swift
//  MDKit
//
//  Created by Mihailo Rancic on 8. 12. 2025..
//

public protocol MatchRepositoryType: Sendable {
    func loadStored() async throws
    
    func fetchAndStoreSports() async throws
    func fetchAndStoreCompetitions() async throws
    func fetchAndStoreMatches() async throws
    
    func getAllSports() async -> [SportEntity]
    func getAllCompetitions() async -> [CompetitionEntity]
    func getAllMatches() async -> [MatchEntity]
    
    func linkRelationships() async throws
}
