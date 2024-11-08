//
//  LevelListItemData.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 9.11.24.
//

import Foundation

struct LevelListItemData: Identifiable {
    let id: Int
    let isLocked: Bool

    init(id: Int, isLocked: Bool) {
        self.id = id
        self.isLocked = isLocked
    }
}
