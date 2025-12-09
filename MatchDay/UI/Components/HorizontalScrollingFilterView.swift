//
//  HorizontalScrollingFilterView.swift
//  MatchDay
//
//  Created by Mihailo Rancic on 9. 12. 2025..
//

import SwiftUI

struct HorizontalScrollingFilterView<Item: Hashable, Content: View>: View {
    private let items: [Item]
    private let content: (Item) -> Content

    init(items: [Item], @ViewBuilder content: @escaping (Item) -> Content) {
        self.items = items
        self.content = content
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(items, id: \.self) { item in
                    content(item)
                }
            }
        }
    }
}
