//
//  LevelListViewModel.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 23.10.24.
//

import SwiftUI

protocol LevelListViewModel: ObservableObject {
    var levelsList: [LevelListItemData] { get }
    func fetchLevels()
}

final class LevelListViewModelImpl: LevelListViewModel {
    private let levelsService: LevelsService
    private let appStateService: AppStateService

    @Published var levelsList: [LevelListItemData] = []

    init(levelsService: LevelsService, appStateService: AppStateService) {
        self.levelsService = levelsService
        self.appStateService = appStateService
        self.fetchLevels()
    }

    func fetchLevels() {
        mapLevels(levels: levelsService.fetchLevels())
    }

    private func mapLevels(levels: [LevelInternal]) {
        let currentLevel = appStateService.getCurrentState().lastLevelId
        self.levelsList = levels.map({ LevelListItemData(id: $0.id,
                                                         isLocked: $0.id > currentLevel) })
    }
}
