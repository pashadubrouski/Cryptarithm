//
//  LevelListItem.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 23.10.24.
//

import SwiftUI

struct LevelListItemData {
    let id: String
    let isLocked: Bool
    let number: Int
    
    init(isLocked: Bool, number: Int) {
        self.isLocked = isLocked
        self.number = number
        self.id = String(number)
    }
}

struct LevelListItem: View {
    private let itemData: LevelListItemData

    init(itemData: LevelListItemData) {
        self.itemData = itemData
    }

    var body: some View {
        Group {
            if itemData.isLocked {
                locked()
            } else {
                unlocked()
            }
        }
    }

    @ViewBuilder private func locked() -> some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Colors.backgroundColor)
            .overlay(alignment: .center) {
                GeometryReader { geometry in
                    Image(systemName: "lock.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width * 0.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundStyle(Colors.foregroundColor)
                        .padding(10)
                }
            }
    }

    @ViewBuilder private func unlocked() -> some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Colors.yellow)
            .overlay(alignment: .center) {
                CText(text: String(itemData.number), 30)
                    .padding([.horizontal, .vertical], 5)
            }
    }
}

#Preview {
    LevelListItem(itemData: LevelListItemData(isLocked: false, number: 1))
}
