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

    private var levels: [Level] = []
    @Published var levelsList: [LevelListItemData] = []

    init(levelsService: LevelsService, appStateService: AppStateService) {
        self.levelsService = levelsService
        self.appStateService = appStateService
        self.fetchLevels()
    }

    func fetchLevels() {
        levels = levelsService.getLevels()
        mapLevels()
    }

    private func mapLevels() {
        let currentLevel = appStateService.getCurrentState().lastLevel
        self.levelsList = levels.map({ LevelListItemData(isLocked: $0.number - 1>currentLevel, number: $0.number) })
    }
}
