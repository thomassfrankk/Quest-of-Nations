//
//  GameSettings.swift
//  Country Quiz
//
//  Created by Thomas Frank on 01/01/26.
//

import SwiftData
import SwiftUI

@Model
final class GameSettings {
    // MARK: - Display Settings
    
    /// The user's preferred appearance mode
    var displayMode: DisplayMode
    
    // MARK: - Audio & Haptics
    
    /// Whether sound effects are enabled
    var isSoundEnabled: Bool
    
    /// Whether haptic feedback is enabled
    var isHapticsEnabled: Bool
    
    // MARK: - Subscription
    
    /// Whether the user has a premium subscription
    var isPremium: Bool
    
    // MARK: - Game Scores
    
    /// Highest score achieved in "What is the Capital?" game
    var capitalGameHighScore: Int
    
    /// Highest score achieved in "What Country?" game
    var countryGameHighScore: Int
    
    /// Highest score achieved in "Flip Match" game
    var matchGameHighScore: Int
    
    init(
        displayMode: DisplayMode = .auto,
        isSoundEnabled: Bool = true,
        isHapticsEnabled: Bool = true,
        isPremium: Bool = false,
        capitalGameHighScore: Int = 0,
        countryGameHighScore: Int = 0,
        matchGameHighScore: Int = 0
    ) {
        self.displayMode = displayMode
        self.isSoundEnabled = isSoundEnabled
        self.isHapticsEnabled = isHapticsEnabled
        self.isPremium = isPremium
        self.capitalGameHighScore = capitalGameHighScore
        self.countryGameHighScore = countryGameHighScore
        self.matchGameHighScore = matchGameHighScore
    }
    
    // MARK: - Helper Methods
    
    static func getOrCreate(in modelContext: ModelContext) -> GameSettings {
        let descriptor = FetchDescriptor<GameSettings>()
        
        do {
            let existingSettings = try modelContext.fetch(descriptor)
            if let settings = existingSettings.first {
                return settings
            }
        } catch {
            print("Error fetching GameSettings: \(error)")
        }
        
        let newSettings = GameSettings()
        modelContext.insert(newSettings)
        try? modelContext.save()
        return newSettings
    }
    
    func syncPremiumStatus(_ isPremium: Bool, in modelContext: ModelContext) {
        self.isPremium = isPremium
        try? modelContext.save()
    }
    
    func updateHighScore(for gameType: GameType, score: Int) {
        switch gameType {
        case .capital:
            if score > capitalGameHighScore {
                capitalGameHighScore = score
            }
        case .country:
            if score > countryGameHighScore {
                countryGameHighScore = score
            }
        case .match:
            if score > matchGameHighScore {
                matchGameHighScore = score
            }
        }
    }
    
    func resetHighScore(for gameType: GameType) {
        switch gameType {
        case .capital:
            capitalGameHighScore = 0
        case .country:
            countryGameHighScore = 0
        case .match:
            matchGameHighScore = 0
        }
    }
    
    func getHighScore(for gameType: GameType) -> Int {
        switch gameType {
        case .capital:
            return capitalGameHighScore
        case .country:
            return countryGameHighScore
        case .match:
            return matchGameHighScore
        }
    }
}

// MARK: - Enums

enum DisplayMode: String, Codable {
    case light = "Light"
    case dark = "Dark"
    case auto = "Auto"
    
    var uiUserInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        case .auto:
            return .unspecified
        }
    }
}

enum GameType: String, Codable {
    case capital = "Capital"
    case country = "Country"
    case match = "Match"
}
