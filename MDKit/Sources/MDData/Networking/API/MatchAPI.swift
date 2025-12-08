//
//  MatchAPI.swift
//  MDKit
//
//  Created by Mihailo Rancic on 8. 12. 2025..
//

import MDDomain

public enum MatchAPI: APIRequest {
    case getAllSports
    case getAllCompetitions
    case getAllMatches
    
    public var endpoint: String {
        switch self {
        case .getAllSports:
            return "/sports"
        case .getAllCompetitions:
            return "/competitions"
        case .getAllMatches:
            return "/matches"
        }
    }
    
    public var method: String {
        return "GET"
    }
}
