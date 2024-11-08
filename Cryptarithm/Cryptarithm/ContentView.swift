//
//  ContentView.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 23.10.24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var appContainer: AppContainer
    @EnvironmentObject private var appRouter: AppRouter

    var body: some View {
        NavigationStack(path: $appRouter.navigationPath) {
            appContainer.makeLevelListAssembly().view()
                .navigationDestination(for: Destination.self) { destination in
                    switch destination {
                    case .levelsList:
                        appContainer.makeLevelListAssembly().view()
                    case .levelDetails(let id):
                        appContainer.makeLevelAssembly().view(id: id)
                            .navigationBarHidden(true)
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
