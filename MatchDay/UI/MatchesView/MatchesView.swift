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
                            .bold(sport.id == viewModel.selectedSportId)
                            .onTapGesture {
                                viewModel.selectedSportId = sport.id
                            }
                    }
                }
            }
            .frame(minHeight: 30)
            .task(id: viewModel.selectedSportId) {
                await viewModel.loadStored()
            }
            
            let liveColumns = viewModel.liveMatches.chunked(into: 2)
            GeometryReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(liveColumns.indices, id: \.self) { index in
                            LazyVGrid(columns: [GridItem(.flexible())], spacing: 16) {
                                ForEach(liveColumns[index], id: \.self) { match in
                                    VStack(spacing: 0) {
                                        Text(match.homeTeam)
                                        Text(" vs ")
                                        Text(match.awayTeam)
                                    }
                                    .border(.red, width: 4)
                                }
                            }
                            .frame(width: proxy.size.width - 32)
                            .padding()
                        }
                    }
                }
                .scrollTargetBehavior(.paging)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .frame(minHeight: 200)
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(DateRange.allCases, id: \.self) { range in
                        Text(range.rawValue)
                            .bold(range == viewModel.selectedDateRange)
                            .onTapGesture {
                                viewModel.selectedDateRange = range
                            }
                    }
                }
            }
            .frame(minHeight: 30)
            .task(id: viewModel.selectedDateRange) {
                await viewModel.loadStored()
            }
            
            let columns = viewModel.matches.chunked(into: 2)
            GeometryReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(columns.indices, id: \.self) { index in
                            LazyVGrid(columns: [GridItem(.flexible())], spacing: 16) {
                                ForEach(columns[index], id: \.self) { match in
                                    VStack(spacing: 0) {
                                        Text(match.homeTeam)
                                        Text(" vs ")
                                        Text(match.awayTeam)
                                    }
                                    .border(.red, width: 4)
                                }
                            }
                            .frame(width: proxy.size.width - 32)
                            .padding()
                        }
                    }
                }
                .scrollTargetBehavior(.paging)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .frame(minHeight: 200)
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
