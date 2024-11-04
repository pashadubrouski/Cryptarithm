//
//  CryptarithmApp.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 23.10.24.
//

import SwiftUI

@main
struct CryptarithmApp: App {
    private let appContainer = AppContainer()
    private let appRouter = AppRouter()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appContainer)
                .environmentObject(appRouter)
        }
    }
}
