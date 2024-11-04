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
    func levelPassed(levelNumber: Int)
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

    func levelPassed(levelNumber: Int) {
        guard let currentState else { return }
        guard levelNumber > currentState.lastLevel else { return }
        self.currentState?.lastLevel = levelNumber
        saveState(self.currentState!)
    }

    func loadState() {
        if let state = userDefaultsService.retrieve(key: key) {
            currentState = state
            return
        } else {
            saveState(AppState())
        }
    }
}
