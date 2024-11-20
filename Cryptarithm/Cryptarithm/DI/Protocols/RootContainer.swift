//
//  RootContainer.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 14.11.24.
//

import SwiftUI

protocol RootContainerInjections {
    var appStateService: AppStateService { get }
    func makeLevelsListContainer() -> LevelsListContainer
}

final class RootContainer: RootContainerInjections {
    lazy var appStateService: AppStateService = {
        return AppStateServiceImpl(userDefaultsService: UserDefaultsService<AppState>())
    }()
}

extension RootContainer: LevelsListContainerDependency {
    func makeLevelsListContainer() -> LevelsListContainer {
        let assembler = LevelsListContainerAssembly(dependency: self)
        return assembler.assemble()
    }
}
