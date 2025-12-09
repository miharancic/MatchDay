//
//  MatchEntity.swift
//  MDKit
//
//  Created by Mihailo Rancic on 8. 12. 2025..
//

import Foundation
import SwiftData
import MDUtils

@Model
public final class MatchEntity: @unchecked Sendable {
    @Attribute(.unique)
    public var id: Int
    public var homeTeam: String
    public var awayTeam: String
    public var homeTeamAvatar: String
    public var awayTeamAvatar: String
    public var date: Date
    public var status: String?
    public var currentTime: String?
    public var result: ResultEntity?
    public var sportId: Int
    public var sport: SportEntity?
    public var competitionId: Int
    public var competition: CompetitionEntity?
    
    public init(id: Int, homeTeam: String, awayTeam: String, homeTeamAvatar: String, awayTeamAvatar: String, date: String, status: String?, currentTime: String?, result: ResultEntity?, sportId: Int, sport: SportEntity?, competitionId: Int, competition: CompetitionEntity?) {
        self.id = id
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.homeTeamAvatar = homeTeamAvatar
        self.awayTeamAvatar = awayTeamAvatar
        
        if let dateFromString = Date.fromDateTimeString(date) {
            self.date = dateFromString
        } else if let dateFromMillis = Date.fromMilliseconds(date) {
            self.date = dateFromMillis
        } else {
            self.date = Date.distantFuture
        }

        self.status = status
        self.currentTime = currentTime
        self.result = result
        self.sportId = sportId
        self.sport = sport
        self.competitionId = competitionId
        self.competition = competition
    }
}
