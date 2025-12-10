//
//  MatchesView.swift
//  MatchDay
//
//  Created by Mihailo Rancic on 8. 12. 2025..
//

import SwiftUI
import MDDomain

struct MatchesView<ViewModel: MatchesViewModelType>: View {
    @Environment(\.appContainer) private var container
    @State var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            HorizontalScrollingFilterView(items: viewModel.sports) { sport in
                HStack(spacing: 4) {
                    RemoteSVGView(urlString: sport.sportIconUrl)
                        .frame(width: 20, height: 20)
                    
                    Text(sport.name)
                        .bold(sport.id == viewModel.selectedSportId)
                        .onTapGesture {
                            viewModel.selectedSportId = sport.id
                        }
                }
            }
            .frame(minHeight: 30)
            .task(id: viewModel.selectedSportId) {
                await viewModel.loadStored()
            }
            
            MatchesGridView(matches: viewModel.liveMatches) { match in
                LiveMatchView(match: match)
            }
            
            HorizontalScrollingFilterView(items: DateRange.allCases) { range in
                Text(range.rawValue)
                    .bold(range == viewModel.selectedDateRange)
                    .onTapGesture {
                        viewModel.selectedDateRange = range
                    }
            }
            .frame(minHeight: 30)
            .task(id: viewModel.selectedDateRange) {
                await viewModel.loadStored()
            }
            
            MatchesGridView(matches: viewModel.matches) { match in
                HStack {
                    RemoteSVGView(urlString: match.homeTeamAvatar)
                        .frame(width: 40, height: 40)
                    VStack(spacing: 0) {
                        Text(match.homeTeam)
                            .frame(maxWidth: .infinity)
                        RemoteSVGView(urlString: match.competition?.sportIconUrl)
                            .frame(width: 20, height: 20)
                            .redacted(reason: match.competition != nil ? [] : .placeholder)
                        Text(match.competition?.name ?? "")
                            .font(.caption)
                            .redacted(reason: match.competition != nil ? [] : .placeholder)
                        Text(match.awayTeam)
                            .frame(maxWidth: .infinity)
                    }
                    RemoteSVGView(urlString: match.homeTeamAvatar)
                        .frame(width: 40, height: 40)
                }
            }
        }
        .padding(.vertical)
        .task {
            await viewModel.loadAllInParallel()
        }
        .refreshable {
            viewModel.refresh()
        }
    }
}

#Preview {
    let container = AppContainer()
    let viewModel = MatchesViewModel(matchRepository: container.matchRepository)
    
    MatchesView(viewModel: viewModel)
}
