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
    
    @State private var canvasView = PKCanvasView()
    @State private var toolPicker = PKToolPicker()
    
    var body: some View {
        DrawingCanvas(canvasView: $canvasView, toolPicker: $toolPicker)
            .onAppear() {
                print(appData.difficultyImage)
            }
    }
}

struct DrawingScreen_Previews: PreviewProvider {
    static var previews: some View {
        DrawingScreen()
    }
}
