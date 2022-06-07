//
//  DrawingScreen.swift
//  PerfectDrawing
//
//  Created by Ethan Chew on 7/6/22.
//

import SwiftUI
import PencilKit

struct DrawingScreen: View {
    
    // Classes
    let appData = AppData()
    let storageManager = StorageManager()
    
    // PencilKit
    @State private var canvasView = PKCanvasView()
    @State private var toolPicker = PKToolPicker()
    
    // Variables
    @State var roundNum: Int = 1
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            HStack {
                switch appData.currentDifficulty {
                case .Easy:
                    Image(uiImage: UIImage(data: appData.imageData.easy[roundNum - 1])!)
                case .Medium:
                    Image(uiImage: UIImage(data: appData.imageData.medium[roundNum - 1])!)
                case .Hard:
                    Image(uiImage: UIImage(data: appData.imageData.hard[roundNum - 1])!)
                case .Extreme:
                    Image(uiImage: UIImage(data: appData.imageData.extreme[roundNum - 1])!)
                case .NotSelected:
                    Image(uiImage: UIImage(data: appData.imageData.easy[roundNum - 1])!)
                }
            }
            DrawingCanvas(canvasView: $canvasView, toolPicker: $toolPicker)
        }
    }
}

struct DrawingScreen_Previews: PreviewProvider {
    static var previews: some View {
        DrawingScreen()
    }
}
