//
//  MatchStoreType.swift
//  MDKit
//
//  Created by Mihailo Rancic on 8. 12. 2025..
//

public protocol MatchStoreType: Sendable {
    func loadSports() async throws -> [SportEntity]
    func storeSports(_ sports: [SportEntity]) async throws
    
    func loadCompetitions() async throws -> [CompetitionEntity]
    func storeCompetitions(_ competitions: [CompetitionEntity]) async throws
    
    func loadMatches() async throws -> [MatchEntity]
    func storeMatches(_ matches: [MatchEntity]) async throws
    
    func linkRelationships() async throws
}
