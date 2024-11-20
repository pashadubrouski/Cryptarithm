//
//  Router.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 20.11.24.
//

import UIKit
typealias Router = Presentable & Pushable
protocol Presentable {
    func fullScreenCover(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
    func fullScreenCover(_ viewController: UIViewController, animated: Bool)
    func showModal(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
    func showModal(_ viewController: UIViewController, animated: Bool)
    func dismissModal(animated: Bool, completion: (() -> Void)?)
    func dismissModal(animated: Bool)
    func dismissAllModals(animated: Bool, completion: (() -> Void)?)
    func dismissAllModals(animated: Bool)
}

protocol Pushable {
    var childs: [UIViewController] { get }
    func show(_ viewController: UIViewController, animated: Bool)
    func hide(animated: Bool)
    func dismissTo(_ viewController: UIViewController, animated: Bool)
    func dismissToRoot(animated: Bool)
}

extension UINavigationController: Presentable {
    func fullScreenCover(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: animated, completion: completion)
    }

    func fullScreenCover(_ viewController: UIViewController, animated: Bool) {
        fullScreenCover(viewController, animated: animated, completion: nil)
    }

    func showModal(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        present(viewController, animated: animated, completion: completion)
    }

    func showModal(_ viewController: UIViewController, animated: Bool) {
        present(viewController, animated: animated)
    }

    func dismissModal(animated: Bool, completion: (() -> Void)?) {
        dismiss(animated: animated, completion: completion)
    }

    func dismissModal(animated: Bool) {
        dismiss(animated: animated, completion: nil)
    }

    func dismissAllModals(animated: Bool, completion: (() -> Void)?) {
        if presentedViewController != nil {
            dismissModal(animated: animated, completion: completion)
        }
    }

    func dismissAllModals(animated: Bool) {
        dismissAllModals(animated: animated, completion: nil)
    }
}

extension UINavigationController: Pushable {
    var childs: [UIViewController] { viewControllers }

    func show(_ viewController: UIViewController, animated: Bool) {
        pushViewController(viewController, animated: animated)
    }

    func hide(animated: Bool) {
        popViewController(animated: animated)
    }

    func dismissTo(_ viewController: UIViewController, animated: Bool) {
        popToViewController(viewController, animated: animated)
    }

    func dismissToRoot(animated: Bool) {
        popToRootViewController(animated: animated)
    }
}
