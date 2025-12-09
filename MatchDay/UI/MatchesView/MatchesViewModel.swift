//
//  MatchesViewModel.swift
//  MatchDay
//
//  Created by Mihailo Rancic on 8. 12. 2025..
//

import SwiftUI
import Observation
import MDDomain

@Observable
final class MatchesViewModel: MatchesViewModelType {
    
    var sports: [SportEntity] = []
    var matches: [MatchEntity] = []
    var liveMatches: [MatchEntity] = []
    
    var selectedSportId = 1
    var selectedDateRange: DateRange = .today
    
    private var loadTask: Task<Void, Never>?

    private let matchRepository: any MatchRepositoryType
    
    init(matchRepository: MatchRepositoryType) {
        self.matchRepository = matchRepository
    }
    
    public func loadStored() async {
        do {
            sports = try await matchRepository.getAllSports()
            matches = try await matchRepository.getMatches(with: selectedSportId, dateRange: selectedDateRange)
            liveMatches = try await matchRepository.getLiveMatches(with: selectedSportId)
        } catch {
            print("Error loading stored matches: \(error)")
        }
    }
    
    public func loadAllInParallel() async {
        await withTaskGroup(of: Void.self) { [weak self] group in
            guard let self = self else { return }
            
            group.addTask {
                await self.fetchAllSports()
            }
            group.addTask {
                await self.fetchAllCompetitions()
            }
            group.addTask {
                await self.fetchAllMatches()
            }
            
            await group.waitForAll()
        }
        
        try? await matchRepository.linkRelationships()
        await loadStored()
    }

    public func refresh() {
        loadTask?.cancel()
        loadTask = Task {
            await loadAllInParallel()
        }
    }
    
    private func fetchAllSports() async {
        do {
            try await matchRepository.fetchAndStoreSports()
            sports = try await matchRepository.getAllSports()
        } catch {
            print("Error fetching sports: \(error)")
        }
    }
    
    private func fetchAllCompetitions() async {
        do {
            try await matchRepository.fetchAndStoreCompetitions()
        } catch {
            print("Error fetching competitions: \(error)")
        }
    }
    
    private func fetchAllMatches() async {
        do {
            try await matchRepository.fetchAndStoreMatches()
            matches = try await matchRepository.getMatches(with: selectedSportId, dateRange: selectedDateRange)
            liveMatches = try await matchRepository.getLiveMatches(with: selectedSportId)
        } catch {
            print("Error fetching matches: \(error)")
        }
    }
}
