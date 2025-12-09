//
//  MatchRepository.swift
//  MDKit
//
//  Created by Mihailo Rancic on 8. 12. 2025..
//

import MDDomain

public actor MatchRepository: MatchRepositoryType {
    private let networkService: any NetworkServiceType
    private let matchStore: any MatchStoreType
    
    public init(networkService: any NetworkServiceType, matchStore: any MatchStoreType) {
        self.networkService = networkService
        self.matchStore = matchStore
    }
    
    public func getAllSports() async throws -> [SportEntity] {
        try await matchStore.loadSports()
    }
    
    public func fetchAndStoreSports() async throws {
        let response = try await networkService.send(MatchAPI.getAllSports, responseType: [SportDTO].self)
        guard response.isEmpty == false else { return }
        let entities = response.map({ SportEntity(id: $0.id, name: $0.name, sportIconUrl: $0.sportIconUrl) })
        try await matchStore.storeSports(entities)
    }
    
    public func fetchAndStoreCompetitions() async throws {
        let response = try await networkService.send(MatchAPI.getAllCompetitions, responseType: [CompetitionDTO].self)
        guard response.isEmpty == false else { return }
        let entities = response.map({ CompetitionEntity(id: $0.id, sportId: $0.sportId, sport: nil, name: $0.name, sportIconUrl: $0.competitionIconUrl) })
        try await matchStore.storeCompetitions(entities)
    }
    
    public func getMatches(with sportId: Int, dateRange: DateRange) async throws -> [MatchEntity] {
        try await matchStore.loadMatches(with: sportId, dateRange: dateRange)
    }
    
    public func getLiveMatches(with sportId: Int) async throws -> [MatchEntity] {
        try await matchStore.loadLiveMatches(with: sportId)
    }
    
    public func fetchAndStoreMatches() async throws {
        let response = try await networkService.send(MatchAPI.getAllMatches, responseType: [MatchDTO].self)
        guard response.isEmpty == false else { return }
        let entities = response.map({ MatchEntity(id: $0.id, homeTeam: $0.homeTeam, awayTeam: $0.awayTeam, homeTeamAvatar: $0.awayTeamAvatar, awayTeamAvatar: $0.awayTeamAvatar, date: $0.date, status: $0.status, currentTime: $0.currentTime, result: $0.result.map { ResultEntity(home: $0.home, away: $0.away) }, sportId: $0.sportId, sport: nil, competitionId: $0.competitionId, competition: nil) })
        try await matchStore.storeMatches(entities)
    }
    
    public func linkRelationships() async throws {
        try await matchStore.linkRelationships()
    }
}
