//
//  LaunchView.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 15.11.24.
//

import SwiftUI

struct LaunchView<ViewModel: LaunchViewModel>: View {
    @ObservedObject private var viewModel: ViewModel
    @State private var isAnimating = false

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            Colors.foregroundColor
                .ignoresSafeArea()
            
            CText(text: Strings.cryptarithm, 30)
                .scaleEffect(isAnimating ? 1.2 : 1.0)
                .animation(
                    .easeInOut(duration: 0.8).repeatForever(autoreverses: true),
                    value: isAnimating
                )
            VStack {
                Button {
                    viewModel.showLevelsList()
                } label: {
                    Text("GO TO LIST")
                }
                .padding(.top, 100)
            }

        }
        .onAppear {
            isAnimating = true
        }
    }
}

struct LoadingIndicator: View {
    let color: Color
    let scale: CGFloat

    @State private var isAnimating: Bool = false

    init(_ color: Color = .black, _ scale: CGFloat = 1) {
        self.color = color
        self.scale = scale
    }

    var body: some View {
        Circle()
            .trim(from: 0.0, to: 0.8)
            .stroke(lineWidth: 3)
            .frame(width: 24 * scale, height: 24 * scale)
            .rotationEffect(.degrees(isAnimating ? 360: 0))
            .foregroundStyle(color)
            .onAppear {
                isAnimating = true
            }
            .animation(repeatAnimation, value: isAnimating)
    }

    var repeatAnimation: Animation {
        Animation
            .linear(duration: 1)
            .repeatForever(autoreverses: false)
    }
}

//#Preview {
//    LaunchView(viewModel: LaunchViewModelImpl())
//}
