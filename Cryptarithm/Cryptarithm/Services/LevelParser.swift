//
//  LevelParser.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 3.11.24.
//

import Foundation

protocol LevelParser {
    func questionToInternalLevel(index: Int, question: String) -> LevelInternal
}

final class LevelParserImpl: LevelParser {

    func questionToInternalLevel(index: Int, question: String) -> LevelInternal {
        let fullComponents = question.components(separatedBy: ";")
        let fullQuestionPart = fullComponents[0]
        let answerPart = fullComponents[1]
        
        
        let components = fullQuestionPart.components(separatedBy: "=")
        let questionParts = components[0]
        let resultPart = components[1]
        
        let questionComponents = questionParts.components(separatedBy: "+")
        
        let questionPartsDictionary: [Int: [String]] = questionComponents.enumerated().reduce(into: [:]) { result, part in
            result[part.offset] = part.element.map { String($0) }
        }
        
        let result: [String] = resultPart.map { String($0) }
        
        return LevelInternal(
            id: index,
            questionParts: questionPartsDictionary,
            result: result,
            mathSymbol: "+",
            answer: parseAnswer(answer: answerPart)
        )
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
