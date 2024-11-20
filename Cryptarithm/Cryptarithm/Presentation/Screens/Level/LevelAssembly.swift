//
//  LevelAssembly.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 23.10.24.
//

import SwiftUI

protocol LevelOutput {
    var onBackButtonTapped: (() -> Void)? { get set }
    var onShowAdTapped: (() -> Void)? { get set }
}

protocol LevelInput {
    var id: Int { get }
}

struct LevelOutputImpl: LevelOutput {
    var onBackButtonTapped: (() -> Void)?
    var onShowAdTapped: (() -> Void)?
}

struct LevelInputImpl: LevelInput {
    var id: Int
}

final class LevelAssembly {
    func create(appStateService: AppStateService,
                levelsService: LevelsService,
                adsService: AdsService,
                output: LevelOutput,
                input: LevelInput) -> some View {
        let levelViewModel: some LevelViewModel & AdsShowable = LevelViewModelImpl(appStateService: appStateService,
                                                                                   levelsService: levelsService,
                                                                                   adsService: adsService,
                                                                                   input: input,
                                                                                   output: output)
        let view = LevelView(viewModel: levelViewModel)
        return view
    }
}
