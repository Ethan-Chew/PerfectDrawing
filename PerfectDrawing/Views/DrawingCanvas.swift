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
    @Binding var toolPicker: PKToolPicker
}

extension DrawingCanvas: UIViewRepresentable {
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.tool = PKInkingTool(.pen, color: .gray, width: 10)
        #if targetEnvironment(simulator)
        canvasView.drawingPolicy = .anyInput
        #endif
        canvasView.backgroundColor = .white
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {}
}

