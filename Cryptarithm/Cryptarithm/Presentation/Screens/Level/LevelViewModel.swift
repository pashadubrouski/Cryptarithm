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
    func backButtonPressed()
    
}

protocol AdsShowable {
    associatedtype AdsView: View
    var showAds: Bool { get }
    func showBannerAd() -> AdsView
    func showInterstitialAd()
}

final class LevelViewModelImpl: LevelViewModel, AdsShowable {
    private let appStateSerivce: AppStateService
    private let levelsService: LevelsService
    private let adsService: AdsService
    private let input: LevelInput
    private let output: LevelOutput
    
    private let levelParser: LevelParser = LevelParserImpl()

    @Published var level: Level
    private var levelOriginal: Level = Level()

    @Published var isDone: Bool = false
    @Published var description: [String] = []
    @Published var selectedLetter: String = "" {
        didSet {
            guard level.isFirstLevel else { return }
            updateDescription()
        }
    }
    @Published var userAnswer: [String : String] = [:]
    @Published var keyboard: [String: Bool] = [:]
    
    @Published var showAds: Bool = true
    @Published var offerAd: Bool = false

    init(appStateService: AppStateService,
         levelsService: LevelsService,
         adsService: AdsService,
         input: LevelInput,
         output: LevelOutput) {
        self.appStateSerivce = appStateService
        self.levelsService = levelsService
        self.adsService = adsService
        self.input = input
        self.output = output
        self.level = levelsService.getLevel(id: input.id)
        self.startLevel()
    }

    private func setupKeyboard() {
        let allKeys = [" ","0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "?"]
        var dictionary = allKeys.reduce(into: [String: Bool]()) { dict, str in
            dict[str] = !userAnswer.values.contains(str)
        }
        dictionary[" "] = true
        dictionary["0"] = !level.firstLetters.contains(selectedLetter)
        keyboard = dictionary
    }

    private func startLevel() {
        withAnimation {
            isDone = false
            self.resetSelection()
            self.levelOriginal = level
            self.userAnswer = level.answer.mapValues { _ in " " }
        }
        if level.isFirstLevel { showAds = false }
    }

    func selectLetter(letter: String) {
        defer { setupKeyboard() }
        guard Character(letter).isLetter else { return }
        withAnimation {
            guard selectedLetter != letter else {
                self.selectedLetter = ""
                return
            }
            self.selectedLetter = letter
        }
    }

    func resetSelection() {
        withAnimation { selectedLetter = "" }
    }

    private func updateDescription() {
        withAnimation {
            selectedLetter == "" ? (description = [Strings.goal, Strings.firstStep]) :
            (description = [Strings.secondStep,  Strings.thirdStep])
        }
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
        if level.answer == userAnswer { levelPassed() }
    }

    private func levelPassed() {
        appStateSerivce.levelPassed(id: level.id)
        withAnimation {
            selectedLetter = ""
            isDone = true
            description = []
        }
    }

    func repeatLevel() {
        withAnimation { startLevel() }
    }

    func nextLevel() {
        self.level = levelsService.getLevel(id: level.id + 1)
        showInterstitialAd()
        startLevel()
    }

    func toggleOfferView() {
        output.onShowAdTapped?()
    }

    func showBannerAd() -> some View {
        return BannerAdView(adsManager: adsService)
    }

    func showInterstitialAd() {
        adsService.loadInterstitialAd()
        adsService.showInterstitialAd()
    }

    func backButtonPressed() {
        output.onBackButtonTapped?()
    }
}
