//
//  Level.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 23.10.24.
//

import Foundation

struct Level: Identifiable, Hashable, Codable {
    let id: String
    let number: Int
    let question: String
    let answer: String

    init(number: Int, question: String, answer: String) {
        self.id = String(number)
        self.number = number
        self.question = question
        self.answer = answer
    }
}
