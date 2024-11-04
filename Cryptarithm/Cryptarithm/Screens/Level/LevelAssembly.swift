//
//  LevelAssembly.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 23.10.24.
//

import SwiftUI

protocol LevelContainer {
    func makeLevelsService() -> LevelsService
    func makeAppStateService() -> AppStateService
}

final class LevelAssembly {
    private let container: LevelContainer

    init(container: LevelContainer) {
        self.container = container
    }

    func view(levelNumber: Int) -> some View {
        let levelViewModel: some LevelViewModel = LevelViewModelImpl(appStateService: container.makeAppStateService(),
                                                                     levelsService: container.makeLevelsService(),
                                                                     levelNumber: levelNumber)
        let view = LevelView(viewModel: levelViewModel)
        return view
    }
}
