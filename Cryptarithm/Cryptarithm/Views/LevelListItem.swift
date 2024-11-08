//
//  LevelListItem.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 23.10.24.
//

import SwiftUI

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
                CText(text: String(itemData.id), 30)
                    .padding([.horizontal, .vertical], 5)
            }
    }
}

#Preview {
    LevelListItem(itemData: LevelListItemData(id: 0, isLocked: false))
}
