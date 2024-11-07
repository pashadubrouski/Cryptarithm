//
//  NavigationView.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 23.10.24.
//

import SwiftUI

enum NavigationButtonImage: String {
    case crown = "crown"
    case goBack = "arrow.left"
}

enum NavigationButtonType {
    case image(image: NavigationButtonImage)
    case systemImage(systemImage: NavigationButtonImage)
    case text(text: String)
}

struct NavigationButton {
    let type: NavigationButtonType
    let action: () -> Void
}

struct NavigationViewConfig {
    let title: String
    let leftButton: NavigationButton?
    let rightButton: NavigationButton?

    init(title: String, leftButton: NavigationButton? = nil, rightButton: NavigationButton? = nil) {
        self.title = title
        self.leftButton = leftButton
        self.rightButton = rightButton
    }
}

struct NavigationView: View {
    private enum Constants {
        static let height: CGFloat = 100
        static let titleFont: Font = Font.custom("LilitaOne", size: 25)
        static let buttonSize: CGFloat = 25
        static let componentPadding: CGFloat = 8
    }

    let config: NavigationViewConfig

    var body: some View {
        HStack {
            makeButton(with: config.leftButton)
                .padding(.all, Constants.componentPadding)
            Spacer()
            CText(text: config.title, 25)
                .foregroundStyle(Colors.foregroundColor)
                .padding(.all, Constants.componentPadding)
            Spacer()
            makeButton(with: config.rightButton)
                .padding(.all, Constants.componentPadding)
        }
        .background(Colors.backgroundColor)
    }

    func makeButton(with data: NavigationButton?) -> some View {
        return Group {
            if let data = data {
                Button(action: data.action) {
                    switch data.type {
                    case .image(let image):
                        Image(image.rawValue)
                            .resizable()
                    case .text(let text):
                        CText(text: text, 20)
                    case .systemImage(let systemImage):
                        Image(systemName: systemImage.rawValue)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(Colors.foregroundColor)
                    }
                }
            } else {
                Spacer()
            }
        }
        .frame(width: Constants.buttonSize, height: Constants.buttonSize)
    }
}

#Preview {
    NavigationView(config: NavigationViewConfig(title: "Levels", rightButton: NavigationButton(type: .image(image: .crown), action: {})))
}
