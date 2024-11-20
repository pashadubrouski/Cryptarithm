//
//  LaunchCoordinator.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 19.11.24.
//

import UIKit
import SwiftUI

final class LaunchCoordinator: Coordinator {
    private let router: Router
    var childCoordninators: [any Coordinator] = []
    var finishFlow: (() -> Void)?

    init(router: Router, finishFlow: (() -> Void)?) {
        self.router = router
        self.finishFlow = finishFlow
    }

    func start() {
        makeLaunchView()
    }

    private func makeLaunchView() {
        let output = LaunchOutputImpl(onFinish: finishFlow)
        let assembly = LaunchAssembly()
        let controller = UIHostingController(rootView: assembly.create(output: output))
        router.show(controller, animated: false)
    }
}
