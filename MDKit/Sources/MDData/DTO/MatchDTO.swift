//
//  MatchDTO.swift
//  MDKit
//
//  Created by Mihailo Rancic on 8. 12. 2025..
//

struct MatchDTO: Codable, Sendable {
    let id: Int
    let homeTeam: String
    let awayTeam: String
    let homeTeamAvatar: String
    let awayTeamAvatar: String
    let date: String
    let status: String?
    let currentTime: String?
    let result: ResultDTO?
    let sportId: Int
    let competitionId: Int
    
    init(id: Int, homeTeam: String, awayTeam: String, homeTeamAvatar: String, awayTeamAvatar: String, date: String, status: String?, currentTime: String?, result: ResultDTO?, sportId: Int, competitionId: Int) {
        self.id = id
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.homeTeamAvatar = homeTeamAvatar
        self.awayTeamAvatar = awayTeamAvatar
        self.date = date
        self.status = status
        self.currentTime = currentTime
        self.result = result
        self.sportId = sportId
        self.competitionId = competitionId
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.homeTeam = try container.decode(String.self, forKey: .homeTeam)
        self.awayTeam = try container.decode(String.self, forKey: .awayTeam)
        self.homeTeamAvatar = try container.decode(String.self, forKey: .homeTeamAvatar)
        self.awayTeamAvatar = try container.decode(String.self, forKey: .awayTeamAvatar)
        
        if let number = try? container.decodeIfPresent(Int.self, forKey: .date) {
            self.date = String(number)
        } else {
            let string = try container.decode(String.self, forKey: .date)
            self.date = string
        }
        
        if let array = try? container.decodeIfPresent([String].self, forKey: .status) {
            self.status = array.joined(separator: ", ")
        } else {
            let string = try? container.decodeIfPresent(String.self, forKey: .status)
            self.status = string
        }
        
        self.currentTime = try container.decodeIfPresent(String.self, forKey: .currentTime)
        self.result = try container.decodeIfPresent(ResultDTO.self, forKey: .result)
        self.sportId = try container.decode(Int.self, forKey: .sportId)
        self.competitionId = try container.decode(Int.self, forKey: .competitionId)
    }
}
