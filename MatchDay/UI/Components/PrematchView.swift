//
//  PrematchView.swift
//  MatchDay
//
//  Created by Mihailo Rancic on 10. 12. 2025..
//

import SwiftUI
import MDDomain

struct PrematchView: View {
    private let match: MatchEntity
    
    init(match: MatchEntity) {
        self.match = match
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .center) {
                RemoteSVGView(urlString: match.homeTeamAvatar)
                    .frame(width: 40, height: 40)
                Text(match.homeTeam)
                    .font(.callout)
                    .bold()
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
            }
            
            VStack {
                RemoteSVGView(urlString: match.competition?.sportIconUrl)
                    .frame(width: 20, height: 20)
                Text(match.competition?.name ?? "")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                
                Text(match.date, format: .dateTime.weekday(.abbreviated))
                    .font(.subheadline)
                Text(match.date, style: .time)
                    .font(.title3)
                    .bold()
            }
            
            VStack(alignment: .center) {
                RemoteSVGView(urlString: match.awayTeamAvatar)
                    .frame(width: 40, height: 40)
                Text(match.awayTeam)
                    .bold()
                    .font(.callout)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.blue, lineWidth: 1)
        )
    }
}
