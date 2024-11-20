//
//  LevelsCoordinator.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 19.11.24.
//

import UIKit
import SwiftUI

final class LevelsCoordinator: Coordinator {
    private let router: Router
    var childCoordninators: [any Coordinator] = []
    var rootViewController: UIViewController?

    private let levelsListContainer: LevelsListContainer

    init(router: Router, levelsListContainer: LevelsListContainer) {
        self.router = router
        self.levelsListContainer = levelsListContainer
    }

    func start() {
        makeLevelsListView()
    }

    private func makeLevelsListView() {
        let output = LevelListOutputImpl(onLevelSelected: makeLevelView)
        let assembly = LevelListAssembly()
        let view = assembly.create(levelsService: levelsListContainer.levelsService,
                                 appStateService: levelsListContainer.appStateService, output: output)
        router.show(UIHostingController(rootView: view), animated: false)
    }

    private func makeLevelView(id: Int) {
        let input = LevelInputImpl(id: id)
        var output = LevelOutputImpl()
        output.onBackButtonTapped = { self.router.hide(animated: true) }
        output.onShowAdTapped = makeAdsView
        let levelContainer = levelsListContainer.makeLevelContainer()
        let assembly = LevelAssembly()
        let view = assembly.create(appStateService: levelContainer.appStateService,
                                   levelsService: levelContainer.levelsService,
                                   adsService: levelContainer.adsService,
                                   output: output,
                                   input: input)
        router.show(UIHostingController(rootView: view), animated: true)
    }

    private func makeAdsView() {
        let assembler = WatchAdAssembly()
        let output = WatchAdOutputImpl { self.router.dismissModal(animated: false) }
        let view = assembler.create(output: output)
        let viewController = UIHostingController(rootView: view)
        viewController.view.backgroundColor = .clear
        router.fullScreenCover(viewController, animated: false)
    }
}
