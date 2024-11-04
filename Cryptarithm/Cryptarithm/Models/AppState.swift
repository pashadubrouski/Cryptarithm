//
//  AppState.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 4.11.24.
//

import Foundation

struct AppState: Codable {
    var adsEnabled: Bool = true
    var lastLevel: Int = 0
    var reviewed: Int? = nil
    var version: Int = 1
    var rewardCount: Int = 0
    var freeLevels: Int = 30
}

//data class AppState(
//    var adsEnabled: Boolean = true,
//    var lastLevel: Int = 0,
//    var reviewed: Int? = null,
//    var version: Long = 3,
//    var rewardCount: Long = 0,
//    var freeLevels: Int = 30,
//    var unlocked: HashSet<Int> = hashSetOf(),
//)
