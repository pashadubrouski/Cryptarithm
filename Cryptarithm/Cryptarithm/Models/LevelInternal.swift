//
//  LevelInternal.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 3.11.24.
//

import Foundation

struct LevelInternal {
    var questionFirstPart: [String]
    var questionSecondPart: [String]
    var result: [String]
    let mathSymbol: String
    let answer: [String: String]

    init(questionFirstPart: [String], questionSecondPart: [String], result: [String], mathSymbol: String, answer: [String: String]) {
        self.questionFirstPart = questionFirstPart
        self.questionSecondPart = questionSecondPart
        self.result = result
        self.mathSymbol = mathSymbol
        self.answer = answer
    }

    init() {
        questionFirstPart = []
        questionSecondPart = []
        result = []
        mathSymbol = ""
        answer = [:]
    }

    var anserDigits: [String] {
        answer.values.map { $0 }
    }

    var longestPart: String {
        if let longestArray = [questionFirstPart, questionSecondPart, result].max(by: { $0.count < $1.count }) {
            return longestArray.joined()
        } else {
            return " "
        }
    }
    
    var firstLetters: [String] {
        return [questionFirstPart[0], questionSecondPart[0], result[0]]
    }
}
