//
//  AppContainer.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 23.10.24.
//

import Foundation

final class AppContainer: ObservableObject {
    private let levelsService: LevelsService = LevelsServiceImpl()
    private let appStateService: AppStateService = AppStateServiceImpl(userDefaultsService: UserDefaultsService<AppState>())
    
    func makeLevelAssembly() -> LevelAssembly {
        LevelAssembly(container: self)
    }

    func makeLevelListAssembly() -> LevelListAssembly {
        LevelListAssembly(container: self)
    }
}

extension AppContainer: LevelListContainer, LevelContainer {
    func makeLevelsService() -> any LevelsService {
        return levelsService
    }

    func makeAppStateService() -> any AppStateService {
        return appStateService
    }
}
