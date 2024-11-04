//
//  NavigationPath.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 3.11.24.
//

import Foundation

enum Destination: Codable, Hashable {
    case levelsList
    case levelDetails(levelNumber: Int)
}
