//
//  LevelListView.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 23.10.24.
//

import SwiftUI

struct LevelView<ViewModel: LevelViewModel & AdsShowable>: View {
    @EnvironmentObject private var appRouter: AppRouter
    @ObservedObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            VStack {
                makeNavigationView()
                viewModel.showBannerAd()
                    .frame(width: 320, height: 50)
                if !viewModel.isDone {
                    ForEach(viewModel.description, id: \.self) { description in
                        CText(text: description, 16)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 5)
                    }
                }
                Spacer()
                makeLevelView()
                Spacer()
                makeAnswersView(data: viewModel.userAnswer)
                Spacer()
                if viewModel.selectedLetter != "" {
                    makeKeyboardView()
                }
                if viewModel.isDone {
                    makeVictoryView()
                }
                Spacer()
                
            }
            .background(Colors.foregroundColor)
            .onTapGesture {
                viewModel.resetSelection()
            }
            if viewModel.offerAd {
                makeAdView()
            }
        }
    }
    
    @ViewBuilder private func makeLevelView() -> some View {
        VStack(spacing: 0) {
            notVisibleWidthComponent(longestPart: viewModel.levelInternal.longestPart, mathSymbol: viewModel.levelInternal.mathSymbol)
            makeTaskView(data: viewModel.levelInternal.questionFirstPart)
            makeMathSymbol(data: viewModel.levelInternal.mathSymbol)
            makeTaskView(data: viewModel.levelInternal.questionSecondPart)
            makeDivider()
            makeTaskView(data: viewModel.levelInternal.result)
        }
        .fixedSize()
        .frame(maxWidth: .infinity, alignment: .center)
    }

    @ViewBuilder private func makeNavigationView() -> some View {
        NavigationView(config: NavigationViewConfig(title: Strings.level(viewModel.level.number),
                                                    leftButton: NavigationButton(type: .systemImage(systemImage: .goBack),
                                                                                 action: { appRouter.dismissToRoot() }),
                                                    rightButton: NavigationButton(type: .image(image: .crown),
                                                                                  action: {})))
    }

    @ViewBuilder private func notVisibleWidthComponent(longestPart: String, mathSymbol: String) -> some View {
        CText(text: longestPart + mathSymbol, 70)
            .frame(height: 0)
            .foregroundStyle(.clear)
    }

    @ViewBuilder private func makeTaskView(data: [String]) -> some View {
        HStack {
            Spacer()
            ForEach(data, id: \.self) { letter in
                CText(text: viewModel.getCurrentValueForLetter(letter: letter), 70)
                    .frame(alignment: .trailing)
                    .padding(.vertical, -0.10*70)
                    .padding(.horizontal, 2)
                    .background(viewModel.selectedLetter == letter ? Colors.yellow : Colors.foregroundColor)
                    .cornerRadius(4)
                    .onTapGesture {
                        viewModel.selectLetter(letter: letter)
                    }
            }
        }
    }

    @ViewBuilder private func makeMathSymbol(data: String) -> some View {
        HStack {
            CText(text: data, 70)
                .frame(alignment: .leading)
                .padding(.vertical, -0.25*70)
            Spacer()
        }
    }

    @ViewBuilder private func makeDivider() -> some View {
        Rectangle()
            .frame(height: 3)
            .foregroundColor(Colors.backgroundColor)
            .padding(.vertical, 4)
    }

    @ViewBuilder private func makeAnswersView(data: [String: String]) -> some View {
        HStack(spacing: 0) {
            ForEach(data.sorted(by: <), id: \.key) { key, value in
                VStack(spacing: 0) {
                    roundedAnswerText(String(key), background: Colors.backgroundColor)
                    .background(viewModel.selectedLetter == key ? Colors.yellow : Colors.foregroundColor)
                    roundedAnswerText(String(value), background: Colors.backgroundColor)
                    .background(viewModel.selectedLetter == key ? Colors.yellow : Colors.foregroundColor)
                }
                .onTapGesture { viewModel.selectLetter(letter: key) }
            }
        }
        .fixedSize()
    }

    @ViewBuilder private func roundedAnswerText(_ text: String, background: Color) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(.clear)
                .border(background, width: 1)
            CText(text: text, 25)
                .foregroundStyle(background)
                .padding(.all, 4)
        }
    }

    @ViewBuilder private func makeKeyboardView() -> some View {
        HStack(spacing: 1) {
            ForEach(viewModel.keyboard.keys.sorted(by: <), id: \.self) { key in
                let available = viewModel.keyboard[key] ?? false
                roundedAnswerText(key, background: Colors.foregroundColor)
                    .background(available ? Colors.backgroundColor: Colors.lightGray)
                    .cornerRadius(4)
                    .onTapGesture {
                        if available { viewModel.answerSelected(digit: key) }
                    }
            }
            .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal, 5)
    }

    @ViewBuilder private func makeVictoryView() -> some View {
        VStack {
            CText(text: Strings.exelent, 40)
            HStack {
                Button {
                    viewModel.repeatLevel()
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 40))
                        .foregroundStyle(Colors.backgroundColor)
                }
                Spacer()
                Button {
                    viewModel.nextLevel()
                } label: {
                    Image(systemName: "arrow.right")
                        .font(.system(size: 40))
                        .foregroundStyle(Colors.backgroundColor)
                }

            }
            .fixedSize()
        }
    }

    @ViewBuilder private func makeAdView() -> some View {
        ZStack {
            Color.black.opacity(0.2)
                .onTapGesture {
                    viewModel.toggleOfferView()
                }
            VStack {
                Spacer()
                WatchAdView(title: Strings.openLetter(viewModel.selectedLetter),
                            action: {})
                .zIndex(1)
            }
            .transition(.asymmetric(insertion: .move(edge: .bottom),
                                    removal: .move(edge: .bottom)))
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
  LevelView(viewModel: LevelViewModelImpl(appStateService: AppStateServiceImpl(userDefaultsService: UserDefaultsService()),
                                          levelsService: LevelsServiceImpl(),
                                          adsService: AdsService(),
                                          levelNumber: 1))
}
