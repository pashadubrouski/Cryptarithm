//
//  Coordinator.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 19.11.24.
//

import Foundation

protocol Coordinator {
    var childCoordninators: [Coordinator] { get }
    func start()
}
