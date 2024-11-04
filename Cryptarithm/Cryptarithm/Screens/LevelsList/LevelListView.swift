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
}

struct LevelListView<ViewModel: LevelListViewModel>: View {
    @EnvironmentObject private var appRouter: AppRouter
    @ObservedObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .center) {
            makeHeader()
            makeLevelsList()
            Spacer()
        }
        .background(Colors.foregroundColor)
        .onAppear {
            viewModel.fetchLevels()
        }
    }

    @ViewBuilder private func makeHeader() -> some View {
        let config = NavigationViewConfig(title: "Levels", rightButton: NavigationButton(type: .image(image: .crown),
                                                                                         action: { print("lol") }))
        NavigationView(config: config)
    }

    @ViewBuilder private func makeLevelsList() -> some View {
        let totalSpaces = Constants.rowsCount + 1
        let width = (UIScreen.main.bounds.width - CGFloat(totalSpaces)*Constants.spacing)/CGFloat(Constants.rowsCount)
        let columns = [GridItem](repeating: GridItem(.fixed(width)), count: Constants.rowsCount)
        ScrollView {
            LazyVGrid(columns: columns, alignment: .center) {
                ForEach(viewModel.levelsList, id: \.id) { level in
                    LevelListItem(itemData: LevelListItemData(isLocked: level.isLocked, number: level.number))
                        .aspectRatio(1, contentMode: .fit)
                        .onTapGesture {
                            if !level.isLocked { appRouter.navigate(to: .levelDetails(levelNumber: level.number)) }
                        }
                }
            }
        }
    }
}

#Preview {
    AppContainer().makeLevelListAssembly().view()
}
