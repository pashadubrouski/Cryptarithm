//
//  WatchAdView.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 20.11.24.
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

struct WatchAdView<ViewModel: WatchAdViewModel>: View {
    @ObservedObject private var viewModel: ViewModel
    @State private var opacity: Double = 0

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            Color.black
                .opacity(0.3)
                .ignoresSafeArea()
            VStack {
                Spacer()
                VStack {
                    CText(text: "Watch letter?", Constants.fontSize)
                        .padding(.vertical, Constants.padding)
                        .foregroundStyle(Colors.foregroundColor)
                    Button(action: viewModel.showAd, label: {
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
                }
                .frame(maxWidth: .infinity)
                .fixedSize(horizontal: false, vertical: true)
                .background(Colors.backgroundColor)
                
            }
        }
        .opacity(opacity)
        .onAppear {
            withAnimation(.smooth(duration: 0.3)) {
                opacity = 1
            }
        }
        .onTapGesture {
            viewModel.dismiss()
        }
    }
}

//#Preview {
//    WatchAdView(viewModel: WatchAdViewModelImpl())
//}
