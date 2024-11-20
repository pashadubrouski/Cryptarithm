//
//  LevelListAssembly.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 23.10.24.
//

import SwiftUI

protocol LevelsListOutput {
    var onLevelSelected: ((Int) -> Void)? { get set }
}

struct LevelListOutputImpl: LevelsListOutput {
    var onLevelSelected: ((Int) -> Void)?
}

final class LevelListAssembly {
    func create(levelsService: LevelsService,
              appStateService: AppStateService,
              output: LevelsListOutput) -> some View {
        let viewModel: some LevelListViewModel = LevelListViewModelImpl(levelsService: levelsService,
                                                                        appStateService: appStateService,
                                                                        output: output)
        let view = LevelListView(viewModel: viewModel)
        return view
    }
}
