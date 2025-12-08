//
//  MatchDayApp.swift
//  MatchDay
//
//  Created by Mihailo Rancic on 8. 12. 2025..
//

import SwiftUI

@main
struct MatchDayApp: App {
    private let container = AppContainerKey.defaultValue
    
    var body: some Scene {
        WindowGroup {
            ContentView()
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
