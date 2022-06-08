//
//  AppData.swift
//  PerfectDrawing
//
//  Created by Ethan Chew on 5/6/22.
//

import Foundation
import Combine
import UIKit

class AppData: ObservableObject {
    let userDefaults = UserDefaults.standard
    
    // Every Image in the Game (Sorted according to Difficulty)
    @Published var imageData: ImageData {
        didSet {
            let encoder = JSONEncoder()
            let data = try? encoder.encode(imageData)
            userDefaults.set(data, forKey: "difficultyImage")
        }
    }
    
    // Last time Data was updated from Firebase Storage
    @Published var lastDataUpdate: Int {
        didSet {
            userDefaults.set(lastDataUpdate, forKey: "lastDataUpdate")
        }
    }
    
    // User's First Open of the App
    @Published var isFirstOpen: Bool {
        didSet {
            userDefaults.set(isFirstOpen, forKey: "isFirstOpen")
        }
    }
    
    // User Selected Difficulty
    @Published var currentDifficulty: GameType {
        didSet {
            var difficulty = ""
            switch currentDifficulty {
            case .Easy:
                difficulty = "Easy"
            case .Medium:
                difficulty = "Medium"
            case .Hard:
                difficulty = "Hard"
            case .Extreme:
                difficulty = "Extreme"
            case .NotSelected:
                difficulty = "NotSelected"
            }
            userDefaults.set(difficulty, forKey: "currentDifficulty")
        }
    }
    
    // Current Game Data
    @Published var gameData: GameData {
        didSet {
            let encoder = JSONEncoder()
            let data = try? encoder.encode(gameData)
            userDefaults.set(data, forKey: "gameData")
        }
    }
    
    init() {
        let decoder = JSONDecoder()

        // Difficulty Image
        let imgData = userDefaults.object(forKey: "difficultyImage") as? Data
        if let imgData = imgData {
            let data = try? decoder.decode(ImageData.self, from: imgData)
            self.imageData = data ?? ImageData(easy: [], medium: [], hard: [], extreme: [])
        } else {
            self.imageData = ImageData(easy: [], medium: [], hard: [], extreme: [])
        }
        
        // Last Data Update
        self.lastDataUpdate = userDefaults.integer(forKey: "lastDataUpdate")
        
        // Is First Open
        self.isFirstOpen = userDefaults.object(forKey: "isFirstOpen") as? Bool ?? true
        
        // Current Difficulty
        let difficulty = userDefaults.string(forKey: "currentDifficulty")
        switch difficulty {
        case "Easy":
            self.currentDifficulty = GameType.Easy
        case "Medium":
            self.currentDifficulty = GameType.Medium
        case "Hard":
            self.currentDifficulty = GameType.Hard
        case "Extreme":
            self.currentDifficulty = GameType.Extreme
        case "NotSelected":
            self.currentDifficulty = GameType.NotSelected
        case .none:
            self.currentDifficulty = GameType.NotSelected
        case .some(_):
            self.currentDifficulty = GameType.NotSelected
        }
        
        // Current Game Data
        let rawData = userDefaults.object(forKey: "gameData") as? Data
        if let rawData = rawData {
            let data = try? decoder.decode(GameData.self, from: rawData)
            self.gameData = data ?? GameData(rounds: [])
        } else {
            self.gameData = GameData(rounds: [])
        }
    }
}
