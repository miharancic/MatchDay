//
//  MatchRepositoryType.swift
//  MDKit
//
//  Created by Mihailo Rancic on 8. 12. 2025..
//

public protocol MatchRepositoryType: Sendable {    
    func fetchAndStoreSports() async throws
    func fetchAndStoreCompetitions() async throws
    func fetchAndStoreMatches() async throws
    
    func getAllSports() async throws -> [SportEntity]
    func getMatches(with sportId: Int, dateRange: DateRange) async throws -> [MatchEntity]
    func getLiveMatches(with sportId: Int) async throws -> [MatchEntity]
    
    func linkRelationships() async throws
}
