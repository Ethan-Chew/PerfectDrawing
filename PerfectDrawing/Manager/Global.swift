//
//  Global.swift
//  PerfectDrawing
//
//  Created by Ethan Chew on 6/6/22.
//

import Foundation
import SwiftUI

enum GameType {
    case Easy, Medium, Hard, Extreme, NotSelected
}

struct ImageData: Codable {
    var easy: [Data]
    var medium: [Data]
    var hard: [Data]
    var extreme: [Data]
}

struct GameData: Codable {
    var rounds: [Round]
}

struct Round: Codable {
    var drawnImage: [Data]
    var shownImage: [Data]
    var score: [Data]
}

func determineRank(data: GameData) {
    
}
