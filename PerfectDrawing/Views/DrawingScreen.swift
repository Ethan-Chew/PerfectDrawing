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
    let compareDrawings = CompareDrawings()
    
    // PencilKit
    @State private var canvasView = PKCanvasView()
    @State private var toolPicker = PKToolPicker()
    
    // Variables
    @State var roundNum: Int = 1
    @State var deleteConfirmation: Bool = false
    @State var submitConfirmaation: Bool = false
    @State var showResultsSheet: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 10) {
                HStack {
                    Image(uiImage: UIImage(data: appData.gameImages[roundNum - 1])!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width/2, height: 200)
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 0) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Image \(roundNum) of 3")
                                .bold()
                                .font(.title)
                                .padding(.bottom, 5)
                            Text("Try to replicate the image to the left as closely as possible!")
                                .font(.title2)
                                .padding(.bottom, 10)
                            Text("When you are done with your drawing, click the Done Button below.")
                                .font(.title2)
                        }
                        .padding(.bottom, 30)
                        
                        Button {
                            submitConfirmaation = true
                        } label: {
                            Text("Submit")
                                .font(.title2)
                                .frame(width: (geometry.size.width/2)/2, height: 40)
                                .padding()
                                .background(.blue)
                                .foregroundColor(.white)
                                .cornerRadius(15)
                        }
                        .padding(.bottom, 10)
                    }
                    
                }
                .padding()
                
                Divider()
                    .frame(width: geometry.size.width/2)
                
                DrawingCanvas(canvasView: $canvasView, toolPicker: $toolPicker)
                    .alert("Are you sure?", isPresented: $deleteConfirmation, actions: {
                        Button("Yes", role: .destructive, action: {
                            canvasView.drawing = PKDrawing()
                        })
                    }, message: {
                        Text("This button will clear your whole canvas (removing your drawing FOREVER).")
                    })
            }
            .alert("Are you sure?", isPresented: $submitConfirmaation, actions: {
                Button("Yes", role: .destructive, action: {
                    var drawnImage: UIImage
                    drawnImage = canvasView.drawing.image(from: canvasView.bounds, scale: CGFloat(1.0))
                    let currentImage = UIImage(data: appData.gameImages[roundNum - 1])!
                    let distance = compareDrawings.compare(origImage: drawnImage.pngData()!, drawnImage: currentImage.pngData()!)
                    if distance != 420.0 {
                        appData.gameData.rounds.append(Round(roundNum: roundNum, drawnImage: drawnImage.pngData()!, shownImage: currentImage.pngData()!, distance: distance))
                        
                        if roundNum < 3 {
                            roundNum += 1
                        } else {
                            
                        }
                    } else {
                        fatalError("Distance Value Error")
                    }
                })
            }, message: {
                Text("Once submitted, you may NOT edit your drawing anymore.")
            })
            .sheet(isPresented: $showResultsSheet) {
                ResultSheet()
            }
            
        }
        .navigationBarTitle("Canvas (\(String(describing: appData.currentDifficulty)) Mode)")
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button {
                    deleteConfirmation = true
                } label: {
                    Image(systemName: "trash")
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
    }
}

private extension DrawingScreen {
    
}

struct DrawingScreen_Previews: PreviewProvider {
    static var previews: some View {
        DrawingScreen()
    }
}
