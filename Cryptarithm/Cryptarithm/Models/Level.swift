//
//  LevelInternal.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 3.11.24.
//

import Foundation

struct Level: Identifiable, Hashable, Codable {
    var id: Int
    var questionParts: [Int: [String]]
    var result: [String]
    let mathSymbol: String
    let answer: [String: String]

    init(id: Int, questionParts: [Int: [String]], result: [String], mathSymbol: String, answer: [String: String]) {
        self.id = id
        self.questionParts = questionParts
        self.result = result
        self.mathSymbol = mathSymbol
        self.answer = answer
    }

    init() {
        id = 0
        questionParts = [:]
        result = []
        mathSymbol = ""
        answer = [:]
    }

    var answerDigits: [String] {
        answer.values.map { $0 }
    }

    var longestPart: String {
        let allParts = Array(questionParts.values) + [result]
        if let longestArray = allParts.max(by: { $0.count < $1.count }) {
            return longestArray.joined()
        } else {
            return " "
        }
    }

    var firstLetters: String {
        let allParts = Array(questionParts.values) + [result]
        return allParts.map { $0.first ?? " " }.joined()
    }

    var isFirstLevel: Bool {
        return id == 1
    }

    var linesCount: Int {
        return questionParts.keys.count
    }
}
