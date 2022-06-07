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
    
    @Published var imageData: ImageData {
        didSet {
            let encoder = JSONEncoder()
            let data = try? encoder.encode(imageData)
            userDefaults.set(data, forKey: "difficultyImage")
        }
    }
    
    @Published var lastDataUpdate: Int {
        didSet {
            userDefaults.set(lastDataUpdate, forKey: "lastDataUpdate")
        }
    }
    
    @Published var isFirstOpen: Bool {
        didSet {
            userDefaults.set(isFirstOpen, forKey: "isFirstOpen")
        }
    }
    
    @Published var currentDifficulty: GameType {
        didSet {
            userDefaults.set(currentDifficulty, forKey: "currentDifficulty")
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
        self.currentDifficulty = userDefaults.object(forKey: "currentDifficulty") as? GameType ?? GameType.NotSelected
    }
}
