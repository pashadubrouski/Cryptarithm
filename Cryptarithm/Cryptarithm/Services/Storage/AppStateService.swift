//
//  AppStateService.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 4.11.24.
//

import Foundation

protocol AppStateService {
    func saveState(_ state: AppState)
    func getCurrentState() -> AppState
    func levelPassed(id: Int)
}

final class AppStateServiceImpl: AppStateService {
    private let userDefaultsService: UserDefaultsService<AppState>
    private let key = "appState"
    private var currentState: AppState?

    init(userDefaultsService: UserDefaultsService<AppState>) {
        self.userDefaultsService = userDefaultsService
        if currentState == nil { loadState() }
    }

    func getCurrentState() -> AppState {
        return currentState ?? AppState()
    }

    func saveState(_ state: AppState) {
        currentState = state
        userDefaultsService.save(value: state, key: key)
    }

    func levelPassed(id: Int) {
        guard let currentState else { return }
        guard id >= currentState.lastLevelId else { return }
        self.currentState?.lastLevelId = id + 1
        saveState(self.currentState!)
    }

    func loadState() {
        guard let state = userDefaultsService.retrieve(key: key) else {
            saveState(AppState())
            return
        }
        currentState = state
    }
}
