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
            print("Error loading stored: \(error)")
        }
    }
    
    public func refreshAllInParallel() async {
        await withTaskGroup(of: Void.self) { [weak self] group in
            guard let self = self else { return }
            
            group.addTask {
                await self.refreshAllSports()
            }
            group.addTask {
                await self.refreshAllCompetitions()
            }
            group.addTask {
                await self.refreshAllMatches()
            }
            
            await group.waitForAll()
        }
        
        do {
            try await matchRepository.linkRelationships()
            await loadStored()
        } catch {
            print("Error linking relationship: \(error)")
        }
    }

    public func refresh() {
        loadTask?.cancel()
        loadTask = Task {
            await refreshAllInParallel()
        }
    }
    
    private func refreshAllSports() async {
        do {
            try await matchRepository.fetchAndStoreSports()
            sports = try await matchRepository.getAllSports()
        } catch {
            print("Error refreshing sports: \(error)")
        }
    }
    
    private func refreshAllCompetitions() async {
        do {
            try await matchRepository.fetchAndStoreCompetitions()
        } catch {
            print("Error refreshing competitions: \(error)")
        }
    }
    
    private func refreshAllMatches() async {
        do {
            try await matchRepository.fetchAndStoreMatches()
            matches = try await matchRepository.getMatches(with: selectedSportId, dateRange: selectedDateRange)
            liveMatches = try await matchRepository.getLiveMatches(with: selectedSportId)
        } catch {
            print("Error refreshing matches: \(error)")
        }
    }
}
