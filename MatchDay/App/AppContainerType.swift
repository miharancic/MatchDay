//
//  AppContainerType.swift
//  MatchDay
//
//  Created by Mihailo Rancic on 8. 12. 2025..
//

import MDDomain

protocol AppContainerType: Sendable {
    var matchRepository: any MatchRepositoryType { get }
}
