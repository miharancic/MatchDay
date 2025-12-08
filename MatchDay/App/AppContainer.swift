//
//  AppContainer.swift
//  MatchDay
//
//  Created by Mihailo Rancic on 8. 12. 2025..
//

import Observation
import MDDomain
import MDData

@Observable
final class AppContainer: AppContainerType {
    private let networkService: any NetworkServiceType
    private let matchStore: any MatchStoreType
    
    let matchRepository: any MatchRepositoryType
    
    init() {
        self.networkService = NetworkService()
        self.matchStore = MatchStore()
        self.matchRepository = MatchRepository(networkService: networkService, matchStore: matchStore)
    }
}
