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
    var competitions: [CompetitionEntity] = []
    var matches: [MatchEntity] = []
    
    private var loadTask: Task<Void, Never>?

    private let matchRepository: any MatchRepositoryType
    
    init(matchRepository: MatchRepositoryType) {
        self.matchRepository = matchRepository
    }
    
    public func loadStored() async {
        do {
            try await matchRepository.loadStored()
            sports = await matchRepository.getAllSports()
            competitions = await matchRepository.getAllCompetitions()
            matches = await matchRepository.getAllMatches()
        } catch {
            print("Error laoding stored matches: \(error)")
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
            sports = await matchRepository.getAllSports()
        } catch {
            print("Error fetching sports: \(error)")
        }
    }
    
    private func fetchAllCompetitions() async {
        do {
            try await matchRepository.fetchAndStoreCompetitions()
            competitions = await matchRepository.getAllCompetitions()
        } catch {
            print("Error fetching competitions: \(error)")
        }
    }
    
    private func fetchAllMatches() async {
        do {
            try await matchRepository.fetchAndStoreMatches()
            matches = await matchRepository.getAllMatches()
        } catch {
            print("Error fetching matches: \(error)")
        }
    }
}
