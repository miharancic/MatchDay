//
//  MatchDayApp.swift
//  MatchDay
//
//  Created by Mihailo Rancic on 8. 12. 2025..
//

import SwiftUI
import SDWebImageSVGCoder

@main
struct MatchDayApp: App {
    private let container = AppContainerKey.defaultValue
    
    init() {
        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)
    }
    
    var body: some Scene {
        WindowGroup {
            MatchesView(viewModel: MatchesViewModel(matchRepository: container.matchRepository))
                .environment(\.appContainer, container)
        }
    }
}

private struct AppContainerKey: EnvironmentKey {
    static let defaultValue = AppContainer()
}

extension EnvironmentValues {
    var appContainer: AppContainer {
        get { self[AppContainerKey.self] }
        set { self[AppContainerKey.self] = newValue }
    }
}
