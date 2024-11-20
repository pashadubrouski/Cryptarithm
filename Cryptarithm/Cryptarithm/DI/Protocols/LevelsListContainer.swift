//
//  LevelsListContainer.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 14.11.24.
//

import Foundation

protocol LevelsListContainerDependency {
    var appStateService: AppStateService { get }
}

protocol LevelsListContainerInjections {
    var appStateService: AppStateService { get }
    var levelsService: LevelsService { get }
}

struct LevelsListContainerAssembly: ContainerAssembly {
    let dependency: LevelsListContainerDependency

    func assemble() -> LevelsListContainer {
        return LevelsListContainer(
            appStateService: dependency.appStateService,
            levelsService: LevelsServiceImpl()
        )
    }
}

final class LevelsListContainer: Container, LevelsListContainerInjections {
    let appStateService: AppStateService
    let levelsService: LevelsService

    init(appStateService: AppStateService, levelsService: LevelsService) {
        self.appStateService = appStateService
        self.levelsService = levelsService
    }
}

extension LevelsListContainer: LevelContainerDependency {
    func makeLevelContainer() -> LevelContainer {
        let assembler = LevelContainerAssembly(dependency: self)
        return assembler.assemble()
    }
}
