//
//  LaunchAssembly.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 15.11.24.
//

import Foundation
import SwiftUI

protocol LaunchOutput {
    var onFinish: (() -> Void)? { get set }
}

struct LaunchOutputImpl: LaunchOutput {
    var onFinish: (() -> Void)?
}

final class LaunchAssembly {
    func create(output: LaunchOutput) -> some View {
        let viewModel: some LaunchViewModel = LaunchViewModelImpl(output: output)
        let view = LaunchView(viewModel: viewModel)
        return view
    }
}
