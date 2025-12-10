//
//  LiveMatchView.swift
//  MatchDay
//
//  Created by Mihailo Rancic on 10. 12. 2025..
//

import SwiftUI
import MDDomain

struct LiveMatchView: View {
    private let match: MatchEntity
    
    init(match: MatchEntity) {
        self.match = match
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 4) {
                RemoteSVGView(urlString: match.competition?.sportIconUrl)
                    .frame(width: 20, height: 20)
                Text(match.competition?.name ?? "")
                    .font(.caption)
                Text(match.currentTime ?? "")
                    .font(.caption)
                Spacer()
            }
            VStack(spacing: 8) {
                HStack(alignment: .center, spacing: 8) {
                    RemoteSVGView(urlString: match.homeTeamAvatar)
                        .frame(width: 30, height: 30)
                    Text(match.homeTeam)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(match.result?.home ?? 0)")
                        .font(.title2)
                        .bold()
                }
                HStack(alignment: .center, spacing: 8) {
                    RemoteSVGView(urlString: match.awayTeamAvatar)
                        .frame(width: 30, height: 30)
                    Text(match.awayTeam)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(match.result?.away ?? 0)")
                        .font(.title2)
                        .bold()
                }
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.blue, lineWidth: 1)
        )
    }
}
