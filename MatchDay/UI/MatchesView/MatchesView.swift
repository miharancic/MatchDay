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
                Text(sport.name)
                    .bold(sport.id == viewModel.selectedSportId)
                    .onTapGesture {
                        viewModel.selectedSportId = sport.id
                    }
            }
            .frame(minHeight: 30)
            .task(id: viewModel.selectedSportId) {
                await viewModel.loadStored()
            }
            
            MatchesGridView(matches: viewModel.liveMatches) { match in
                VStack(spacing: 0) {
                    Text(match.homeTeam)
                    Text(" vs ")
                    Text(match.awayTeam)
                }
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
                VStack(spacing: 0) {
                    Text(match.homeTeam)
                    Text(" vs ")
                    Text(match.awayTeam)
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
