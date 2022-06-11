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

struct Round: Codable, Identifiable {
    var id = UUID()
    var roundNum: Int
    var drawnImage: URL
    var shownImage: URL
    var distance: Float
    
    var rank: String
    var percentage: Float
}

func determinePercentage(roundData: Round) -> Float {
    var roundDist = roundData.distance
    if roundDist > 27.0 { roundDist = 27.0 }
    
    return 1.0-((roundDist-38)/27.0)*100.0
}

func determineRank(percentage: Float) -> String {
    if percentage >= 90.0 {
        return "A++"
    } else if percentage >= 80.0 {
        return "A+"
    } else if percentage >= 65.0 {
        return "A"
    } else if percentage >= 60.0 {
        return "B+"
    } else if percentage >= 50.0 {
        return "B"
    } else if percentage >= 40.0 {
        return "C"
    } else if percentage >= 30.0 {
        return "D"
    } else {
        return "F"
    }
}
