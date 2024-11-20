//
//  LevelListView.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 23.10.24.
//

import SwiftUI

fileprivate enum Constants {
    static let rowsCount = 5
    static let spacing: CGFloat = 10
    static let backgroundColor = Colors.foregroundColor
}

struct LevelListView<ViewModel: LevelListViewModel>: View {
    @ObservedObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                makeNavigationView()
                makeLevelsList()
                Spacer()
                    .frame(height: geometry.safeAreaInsets.bottom)
            }
            .ignoresSafeArea(edges: .bottom)
            .background(Constants.backgroundColor)
            .onAppear(perform: onAppear)
        }
    }

    private func onAppear() {
        viewModel.fetchLevels()
    }

    @ViewBuilder private func makeNavigationView() -> some View {
        let config = NavigationViewConfig(title: Strings.levels,
                                          rightButton: NavigationButton(type: .image(image: .crown),
                                                                        action: { }))
        NavigationView(config: config)
    }

    @ViewBuilder private func makeLevelsList() -> some View {
        let totalSpaces = Constants.rowsCount + 1
        let width = (UIScreen.main.bounds.width - CGFloat(totalSpaces)*Constants.spacing)/CGFloat(Constants.rowsCount)
        let columns = [GridItem](repeating: GridItem(.fixed(width)), count: Constants.rowsCount)

        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, alignment: .center) {
                ForEach(viewModel.levelsList, id: \.id) { level in
                    LevelListItem(itemData: level)
                        .aspectRatio(1, contentMode: .fit)
                        .onTapGesture { viewModel.levelSelected(id: level.id) }
                }
            }
        }
    }
}

