//
//  LaunchViewModel.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 15.11.24.
//

import Foundation

protocol LaunchViewModel: ObservableObject {
    func showLevelsList()
}

final class LaunchViewModelImpl: LaunchViewModel {
    private let output: LaunchOutput

    init(output: LaunchOutput) {
        self.output = output
    }

    func showLevelsList() {
        output.onFinish?()
    }
}
