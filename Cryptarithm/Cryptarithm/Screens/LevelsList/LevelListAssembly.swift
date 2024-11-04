//
//  LevelListAssembly.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 23.10.24.
//

import SwiftUI

protocol LevelListContainer {
    func makeLevelsService() -> LevelsService
    func makeAppStateService() -> AppStateService
}

final class LevelListAssembly {
    private let container: LevelListContainer
    
    init(container: LevelListContainer) {
        self.container = container
    }

    func view() -> some View {
        let viewModel: some LevelListViewModel = LevelListViewModelImpl(levelsService: container.makeLevelsService(),
                                                                        appStateService: container.makeAppStateService())
        let view = LevelListView(viewModel: viewModel)
        return view
    }
}
