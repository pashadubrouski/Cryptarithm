//
//  AppState.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 4.11.24.
//

import Foundation

struct AppState: Codable {
    var adsEnabled: Bool = true
    var lastLevelId: Int = 1
    var reviewed: Int? = nil
    var version: Int = 1
    var rewardCount: Int = 0
    var freeLevels: Int = 30
}
