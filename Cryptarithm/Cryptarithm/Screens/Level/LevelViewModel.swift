//
//  LevelViewModel.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 23.10.24.
//

import SwiftUI

protocol LevelViewModel: ObservableObject {
    var level: Level { get }
    var isDone: Bool { get }
    var description: [String] { get }
    var selectedLetter: String { get set }
    var levelInternal: LevelInternal { get }
    var userAnswer: [String: String] { get set }
    var offerAd: Bool { get set }
    var keyboard: [String: Bool] { get }
    func getCurrentValueForLetter(letter: String) -> String
    func selectLetter(letter: String)
    func resetSelection()
    func answerSelected(digit: String)
    func repeatLevel()
    func nextLevel()
    func toggleOfferView()
}

protocol AdsShowable {
    associatedtype AdsView: View
    func showBannerAd() -> AdsView
    func showInterstitialAd()
}

final class LevelViewModelImpl: LevelViewModel, AdsShowable {
    private let appStateSerivce: AppStateService
    private let levelsService: LevelsService
    private let adsService: AdsService
    private let levelParser: LevelParser = LevelParserImpl()
    
    @Published var level: Level
    @Published var isDone: Bool = false
    @Published var description: [String] = []
    @Published var selectedLetter: String = ""
    private var levelInternalOriginal: LevelInternal = LevelInternal()
    @Published var levelInternal: LevelInternal = LevelInternal()
    @Published var userAnswer: [String : String] = [:]
    @Published var offerAd: Bool = false
    @Published var keyboard: [String: Bool] = [:]

    init(appStateService: AppStateService, levelsService: LevelsService, adsService: AdsService, levelNumber: Int) {
        self.appStateSerivce = appStateService
        self.levelsService = levelsService
        self.adsService = adsService
        self.level = levelsService.getLevel(number: levelNumber)
        if level.number == 1 { self.description = [Strings.goal, Strings.firstStep] }
        self.startLevel()
        self.setupKeyboard()
        
    }

    private func setupKeyboard() {
        let allKeys = [" ","0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "?"]
        var dictionary = allKeys.reduce(into: [String: Bool]()) { dict, str in
            dict[str] = !userAnswer.values.contains(str)
        }
        dictionary[" "] = true
        dictionary["0"] = !levelInternal.firstLetters.contains(selectedLetter)
        keyboard = dictionary
    }

    private func startLevel() {
        withAnimation {
            isDone = false
            self.resetSelection()
            self.levelInternalOriginal = levelParser.levelToInternal(level: level)
            self.levelInternal = levelInternalOriginal
            self.userAnswer = levelInternal.answer.mapValues { _ in " " }
        }
    }

    func selectLetter(letter: String) {
        defer {
            if level.number == 1 { updateDescription() }
            setupKeyboard()
        }
        withAnimation {
            if Character(letter).isLetter {
                guard selectedLetter != letter else {
                    self.selectedLetter = ""
                    return
                }
                self.selectedLetter = letter
            } else {
                return
            }
        }
    }

    func resetSelection() {
        withAnimation {
            selectedLetter = ""
            updateDescription()
        }
    }

    private func updateDescription() {
        guard level.number == 1 else {
            description = []
            return
        }
        selectedLetter == "" ? (description = [Strings.goal, Strings.firstStep]) :
        (description = [Strings.secondStep,  Strings.thirdStep])
    }

    func answerSelected(digit: String) {
        defer { setupKeyboard() }
        guard digit != " " else {
            userAnswer.updateValue(String(" "), forKey: String(selectedLetter))
            return
        }
        guard digit != "?" else {
            toggleOfferView()
            return
        }
        userAnswer.updateValue(String(digit), forKey: String(selectedLetter))
        checkAnswers()
    }

    func getCurrentValueForLetter(letter: String) -> String {
        guard let value = userAnswer[String(letter)], value != " " else { return letter }
        return value
    }

    private func checkAnswers() {
        if levelInternal.answer == userAnswer {
           levelPassed()
        }
    }

    private func levelPassed() {
        appStateSerivce.levelPassed(levelNumber: level.number)
        withAnimation {
            selectedLetter = ""
            isDone = true
        }
    }

    func repeatLevel() {
        withAnimation {
           startLevel()
        }
    }

    func nextLevel() {
        levelsService.setNextLevel()
        self.level = levelsService.getLevel(number: level.number + 1)
        showInterstitialAd()
        startLevel()
    }

    func toggleOfferView() {
        withAnimation {
            offerAd.toggle()
        }
    }

    func showBannerAd() -> some View {
        return BannerAdView(adsManager: adsService)
    }

    func showInterstitialAd() {
        adsService.loadInterstitialAd()
        adsService.showInterstitialAd()
    }
}
