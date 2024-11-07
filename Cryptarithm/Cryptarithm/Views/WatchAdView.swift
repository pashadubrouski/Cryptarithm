//
//  WatchAdView.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 4.11.24.
//

import SwiftUI

fileprivate enum Constants {
    static let padding: CGFloat = 20
    static let buttonInternalPadding: CGFloat = 20
    static let cornerRadius: CGFloat = 25
    static let fontSize: CGFloat = 25
    static let iconSize: CGFloat = 50
    static let icon = "film"
}

struct WatchAdView: View {
    
    let title: String
    let action: () -> Void
    
    init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    var body: some View {
        VStack {
            CText(text: title, Constants.fontSize)
                .padding(.vertical, Constants.padding)
                .foregroundStyle(Colors.foregroundColor)
            Button(action: action, label: {
                HStack {
                    Image(systemName: Constants.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: Constants.iconSize)
                    CText(text: Strings.watchAd, Constants.fontSize)
                }
                .padding(.all, Constants.buttonInternalPadding)
            })
            .foregroundStyle(Colors.backgroundColor)
            .background(Colors.yellow)
            .cornerRadius(Constants.cornerRadius)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .fixedSize(horizontal: false, vertical: true)
        .background(Colors.backgroundColor)
    }
}

#Preview {
    WatchAdView(title: "Open the letter \"A\"", action: {})
}
