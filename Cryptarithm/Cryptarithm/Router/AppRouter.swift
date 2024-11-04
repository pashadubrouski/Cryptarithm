//
//  AppRouter.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 3.11.24.
//

import SwiftUI

final class AppRouter: ObservableObject {
    @Published var navigationPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navigationPath.append(destination)
    }

    func dismiss() {
        navigationPath.removeLast()
    }

    func dismissToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
}


