//
//  RemoteSVGView.swift
//  MatchDay
//
//  Created by Mihailo Rancic on 9. 12. 2025..
//

import SwiftUI
import SDWebImageSwiftUI

struct RemoteSVGView: View {
    private let urlString: String?
    
    init(urlString: String?) {
        self.urlString = urlString
    }

    var body: some View {
        if let url = URL(string: urlString ?? "") {
            WebImage(url: url)
                .resizable()
        } else {
            EmptyView()
        }
    }
}
