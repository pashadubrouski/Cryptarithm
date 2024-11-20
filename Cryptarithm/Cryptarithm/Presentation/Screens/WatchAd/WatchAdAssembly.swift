//
//  WatchAdAssembly.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 20.11.24.
//

import SwiftUI

protocol WatchAdOutput {
    var onDismissTapped: (() -> Void)? { get set }
}

struct WatchAdOutputImpl: WatchAdOutput {
    var onDismissTapped: (() -> Void)?
}

final class WatchAdAssembly {
    func create(output: WatchAdOutput) -> some View {
        let viewModel = WatchAdViewModelImpl(output: output)
        let view = WatchAdView(viewModel: viewModel)
        return view
    }
}
