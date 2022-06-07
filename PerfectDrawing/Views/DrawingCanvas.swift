//
//  DrawingCanvas.swift
//  PerfectDrawing
//
//  Created by Ethan Chew on 7/6/22.
//

import Foundation
import PencilKit
import SwiftUI

struct DrawingCanvas {
    @Binding var canvasView: PKCanvasView
}

extension DrawingCanvas: UIViewRepresentable {
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.tool = PKInkingTool(.pen, color: .gray, width: 10)
        #if targetEnvironment(simulator)
        canvasView.drawingPolicy = .anyInput
        #endif
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {}
}

