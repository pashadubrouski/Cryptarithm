//
//  LevelsService.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 23.10.24.
//

import Foundation

protocol LevelsService {
    func getLevels() -> [Level]
    func getLevel(number: Int) -> Level
    func setNextLevel()
}

final class LevelsServiceImpl: LevelsService {
    private var currentLevel = 1
    func getLevels() -> [Level] {
        return [Level(number: 1, question: "A+A=2", answer: "A1"),
                Level(number: 2, question: "B+3=5", answer: "B2"),
                Level(number: 3, question: "AB+22=63", answer: "A4B1"),
                Level(number: 4, question: "81+B=BA", answer: "A0B9"),
                Level(number: 5, question: "AS+A=MOM", answer: "A9M1O0S2"),
                Level(number: 6, question: "HI+I=SE", answer: "E0H9I5S1"),
                Level(number: 7, question: "TO+GO=OUT", answer: "G8O1T2U0"),
                Level(number: 8, question: "HACK+HACKER=REBOOT", answer: "A9B1C6E0H4K8O7R5T3"),
        ]
    }

    func getLevel(number: Int) -> Level {
        return getLevels().first { $0.number == number }!
    }

    func setNextLevel() {
        currentLevel += 1
    }
}
