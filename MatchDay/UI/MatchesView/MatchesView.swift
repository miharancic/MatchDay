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
                SportView(sport: sport)
            }
            .task(id: viewModel.selectedSportId) {
                await viewModel.loadStored()
            }
            
            MatchesGridView(matches: viewModel.liveMatches) { match in
                LiveMatchView(match: match)
            }
            
            HorizontalScrollingFilterView(items: DateRange.allCases) { range in
                DateRangeView(range: range)
            }
            .task(id: viewModel.selectedDateRange) {
                await viewModel.loadStored()
            }
            
            MatchesGridView(matches: viewModel.matches) { match in
                PrematchView(match: match)
            }
        }
        .padding(.vertical)
        .task {
            await viewModel.refreshAllInParallel()
        }
        .refreshable {
            viewModel.refresh()
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private func SportView(sport: SportEntity) -> some View {
        HStack(spacing: 4) {
            RemoteSVGView(urlString: sport.sportIconUrl)
                .frame(width: 20, height: 20)
            
            Text(sport.name)
                .bold(sport.id == viewModel.selectedSportId)
                
        }
        .onTapGesture {
            viewModel.selectedSportId = sport.id
        }
    }
    
    private func DateRangeView(range: DateRange) -> some View {
        Text(range.rawValue)
            .bold(range == viewModel.selectedDateRange)
            .onTapGesture {
                viewModel.selectedDateRange = range
            }
    }
}

#Preview {
    let container = AppContainer()
    let viewModel = MatchesViewModel(matchRepository: container.matchRepository)
    
    MatchesView(viewModel: viewModel)
}
