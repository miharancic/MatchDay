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
    var matches: [MatchEntity] { get }
    var liveMatches: [MatchEntity] { get }
    
    var selectedSportId: Int { get set }
    var selectedDateRange: DateRange { get set }
    
    func loadStored() async
    func loadAllInParallel() async
    func refresh()
}
