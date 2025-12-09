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
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.sports) { sport in
                        Text(sport.name)
                            .onTapGesture {
                                viewModel.selectedSportId = sport.id
                            }
                    }
                }
            }
            .frame(minHeight: 50)
            
            Spacer(minLength: 50)
            
            ForEach(viewModel.liveMatches) { match in
                HStack {
                    Text(match.homeTeam) + Text(" vs ") + Text(match.awayTeam)
                }
            }
            
            Spacer(minLength: 50)
            
            ForEach(viewModel.matches) { match in
                HStack {
                    Text(match.homeTeam) + Text(" vs ") + Text(match.awayTeam)
                }
            }
        }
        .task(id: viewModel.selectedSportId) {
            await viewModel.loadStored()
        }
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
