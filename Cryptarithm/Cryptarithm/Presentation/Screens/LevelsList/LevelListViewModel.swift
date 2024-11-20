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
    func levelSelected(id: Int)
}

final class LevelListViewModelImpl: LevelListViewModel {
    private let levelsService: LevelsService
    private let appStateService: AppStateService

    private let output: LevelsListOutput

    @Published var levelsList: [LevelListItemData] = []

    init(levelsService: LevelsService, appStateService: AppStateService, output: LevelsListOutput) {
        self.levelsService = levelsService
        self.appStateService = appStateService
        self.output = output
        self.fetchLevels()
    }

    func fetchLevels() {
        mapLevels(levels: levelsService.fetchLevels())
    }

    private func mapLevels(levels: [Level]) {
        let currentLevel = appStateService.getCurrentState().lastLevelId
        self.levelsList = levels.map({ LevelListItemData(id: $0.id,
                                                         isLocked: $0.id > currentLevel) })
    }

    func levelSelected(id: Int) {
        guard let level = self.levelsList.first(where: { $0.id == id }) else { return }
        guard !level.isLocked else { return }
        output.onLevelSelected?(id)
    }
}
