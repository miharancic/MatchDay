//
//  MatchStore.swift
//  MDKit
//
//  Created by Mihailo Rancic on 8. 12. 2025..
//

import MDDomain
import SwiftData
import Foundation

public actor MatchStore: MatchStoreType {
    private let modelContext: ModelContext
    
    public init() {
        let storeURL = URL.documentsDirectory.appendingPathComponent("MatchStore.sqlite")
        let config = ModelConfiguration(url: storeURL)
        let container = try! ModelContainer(for: SportEntity.self, CompetitionEntity.self, MatchEntity.self, ResultEntity.self, configurations: config)
        self.modelContext = DefaultSerialModelExecutor(modelContext: ModelContext(container)).modelContext
    }
    
    public func loadSports() async throws -> [SportEntity] {
        let descriptor = FetchDescriptor<SportEntity>(
            sortBy: [SortDescriptor(\SportEntity.id, order: .forward)]
        )
        return try modelContext.fetch(descriptor)
    }
    
    public func storeSports(_ sports: [SportEntity]) async throws {
        for sport in sports {
            modelContext.insert(sport)
        }
        try modelContext.save()
    }
    
    public func storeCompetitions(_ competitions: [CompetitionEntity]) async throws {
        for competition in competitions {
            modelContext.insert(competition)
        }
        try modelContext.save()
    }
    
    public func loadMatches() async throws -> [MatchEntity] {
        let predicate = #Predicate<MatchEntity> { match in
            match.status?.contains("LIVE") == false
        }
        let descriptor = FetchDescriptor<MatchEntity>(
            predicate: predicate, sortBy: [SortDescriptor(\MatchEntity.id, order: .forward)]
        )
        return try modelContext.fetch(descriptor)
    }
    
    public func loadLiveMatches() async throws -> [MatchEntity] {
        let predicate = #Predicate<MatchEntity> { match in
            match.status?.contains("LIVE") == true
        }
        let descriptor = FetchDescriptor<MatchEntity>(
            predicate: predicate, sortBy: [SortDescriptor(\MatchEntity.id, order: .forward)]
        )
        return try modelContext.fetch(descriptor)
    }
    
    public func loadMatches(with sportId: Int) async throws -> [MatchEntity] {
        let predicate = #Predicate<MatchEntity> { match in
            match.sportId == sportId && match.status?.contains("LIVE") == false
        }
        
        let descriptor = FetchDescriptor<MatchEntity>(
            predicate: predicate, sortBy: [SortDescriptor(\MatchEntity.id, order: .forward)]
        )
        return try modelContext.fetch(descriptor)
    }
    
    public func loadLiveMatches(with sportId: Int) async throws -> [MatchEntity] {
        let predicate = #Predicate<MatchEntity> { match in
            match.sportId == sportId && match.status?.contains("LIVE") == true
        }
        
        let descriptor = FetchDescriptor<MatchEntity>(
            predicate: predicate, sortBy: [SortDescriptor(\MatchEntity.id, order: .forward)]
        )
        return try modelContext.fetch(descriptor)
    }
    
    public func storeMatches(_ matches: [MatchEntity]) async throws {
        let existing = try modelContext.fetch(FetchDescriptor<MatchEntity>())
        let incomingIDs = Set(matches.map { $0.id })
        
        for old in existing where !incomingIDs.contains(old.id) {
            if !incomingIDs.contains(old.id) {
                modelContext.delete(old)
            }
        }

        for match in matches {
            modelContext.insert(match)
        }

        try modelContext.save()
    }
    
    public func linkRelationships() async throws {
        let sports = try modelContext.fetch(FetchDescriptor<SportEntity>())
        let competitions = try modelContext.fetch(FetchDescriptor<CompetitionEntity>())
        let matches = try modelContext.fetch(FetchDescriptor<MatchEntity>())

        let sportsById = Dictionary(uniqueKeysWithValues: sports.map { ($0.id, $0) })
        let competitionsById = Dictionary(uniqueKeysWithValues: competitions.map { ($0.id, $0) })

        for competition in competitions {
            let sport = sportsById[competition.sportId]
            competition.sport = sport
        }

        for match in matches {
            if let sport = sportsById[match.sportId] {
                match.sport = sport
            }
            if let comp = competitionsById[match.competitionId] {
                match.competition = comp
            }
        }

        try modelContext.save()
    }
}
