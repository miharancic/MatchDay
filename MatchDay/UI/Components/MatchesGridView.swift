//
//  MatchesGridView.swift
//  MatchDay
//
//  Created by Mihailo Rancic on 9. 12. 2025..
//

import SwiftUI
import MDDomain

struct MatchesGridView<Content: View>: View {
    private var matches: [MatchEntity]
    private let content: (MatchEntity) -> Content
    
    private let spacing: CGFloat = 16

    init(matches: [MatchEntity], @ViewBuilder content: @escaping (MatchEntity) -> Content) {
        self.matches = matches
        self.content = content
    }

    var body: some View {
        let columns = matches.chunked(into: 2)
        GeometryReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(columns.indices, id: \.self) { index in
                        LazyVGrid(columns: [GridItem(.flexible())], spacing: spacing) {
                            ForEach(columns[index], id: \.self) { match in
                                content(match)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                        }
                        .frame(width: proxy.size.width - 2 * spacing)
                        .padding()
                    }
                }
            }
            .scrollTargetBehavior(.paging)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .frame(minHeight: 320)
    }
}
