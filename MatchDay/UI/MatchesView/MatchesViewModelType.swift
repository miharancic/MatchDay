//
//  MatchesViewModelType.swift
//  MatchDay
//
//  Created by Mihailo Rancic on 8. 12. 2025..
//

import SwiftUI
import MDDomain

@MainActor protocol MatchesViewModelType {
    var sports: [SportEntity] { get }
    var competitions: [CompetitionEntity] { get }
    var matches: [MatchEntity] { get }
    
    func loadStored() async
    func loadAllInParallel() async
    func refresh()
}
