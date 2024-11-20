//
//  LevelContainer.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 20.11.24.
//

import Foundation

protocol LevelContainerDependency {
    var appStateService: AppStateService { get }
    var levelsService: LevelsService { get }
}

protocol LevelContainerInjections {
    var appStateService: AppStateService { get }
    var levelsService: LevelsService { get }
    var adsService: AdsService { get }
}

struct LevelContainerAssembly: ContainerAssembly {
    let dependency: LevelContainerDependency

    func assemble() -> LevelContainer {
        LevelContainer(appStateService: dependency.appStateService,
                       levelsService: dependency.levelsService,
                       adsService: AdsService())
    }
}

final class LevelContainer: Container, LevelContainerInjections {
    let appStateService: AppStateService
    let levelsService: LevelsService
    let adsService: AdsService

    init(appStateService: AppStateService, levelsService: LevelsService, adsService: AdsService) {
        self.appStateService = appStateService
        self.levelsService = levelsService
        self.adsService = adsService
    }
}
