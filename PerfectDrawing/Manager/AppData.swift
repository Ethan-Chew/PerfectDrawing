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
    
    @Published var difficultyImage: [UIImage] {
        didSet {
            userDefaults.set(difficultyImage, forKey: "difficultyImage")
        }
    }
    
    init() {
        self.difficultyImage = userDefaults.object(forKey: "difficultyImage") as? [UIImage] ?? []
    }
}
