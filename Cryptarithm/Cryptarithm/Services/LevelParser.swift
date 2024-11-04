//
//  LevelParser.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 3.11.24.
//

import Foundation

protocol LevelParser {
    func levelToInternal(level: Level) -> LevelInternal
}

final class LevelParserImpl: LevelParser {

    func levelToInternal(level: Level) -> LevelInternal {
        let components = level.question.components(separatedBy: "=")
        let questionParts = components[0].components(separatedBy: "+")
        let resultPart: [Character] = Array(components[1])
        
        let questionFirstPart: [String] = questionParts[0].map { String($0) }
        let questionSecondPart: [String] = questionParts[1].map { String($0) }
        let result: [String] = resultPart.map { String($0) }

        return LevelInternal(questionFirstPart: questionFirstPart,
                             questionSecondPart: questionSecondPart,
                             result: result,
                             mathSymbol: "+",
                             answer: parseAnswer(answer: level.answer))
    }
    
    func parseAnswer(answer: String) -> [String: String] {
        let answerArray: [Character] = Array(answer)
        let pairs = stride(from: 0, to: answerArray.count - 1, by: 2).compactMap { index -> (Character, Character)? in
            let letter = answerArray[index]
            let digit = answerArray[index + 1]
            guard letter.isLetter, digit.isNumber else { return nil }
            return (letter, digit)
        }
        
        return pairs.reduce(into: [:]) { result, pair in
            result[String(pair.0)] = String(pair.1)
        }
    }
}
