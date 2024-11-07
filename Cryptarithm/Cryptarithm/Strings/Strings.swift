//
//  Strings.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 7.11.24.
//

import Foundation
import SwiftUI

enum Strings {
    static let watchAd = "watchAd"
    static let unlockAsk = "unlockAsk"

    static let thanks = "thanks"
    static let tapToRateDescription = "tapToRateDescription"
    static let tapToRate = "tapToRate"
    static let rate = "rate"
    static func openLetter(_ letter: String) -> String {
        return String(localized: "openLetterAsk")
    }
    static let levels = "levels"
    static func level(_ level: Int) -> String {
        return String(localized: "levelTitle \(level)")
    }

    static let exelent = "excellent"
    static let enjoyGameAsk = "enjoyGameAsk"
    static let cryptarithm = "cryptarithm"
    static let checkNetwork = "checkNetwork"

    //MARK: - Steps
    static let goal = "goal"
    static let firstStep = "firstStep"
    static let secondStep = "secondStep"
    static let thirdStep = "thirdStep"
}
