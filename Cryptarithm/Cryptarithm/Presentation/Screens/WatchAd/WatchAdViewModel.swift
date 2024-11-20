//
//  WatchAdViewModel.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 20.11.24.
//

import Foundation

protocol WatchAdViewModel: ObservableObject {
    func showAd()
    func dismiss()
}

final class WatchAdViewModelImpl: WatchAdViewModel {
    private var output: WatchAdOutput

    init(output: WatchAdOutput) {
        self.output = output
    }

    func showAd() {
        print("Here should be add")
    }

    func dismiss() {
        output.onDismissTapped?()
    }
}

