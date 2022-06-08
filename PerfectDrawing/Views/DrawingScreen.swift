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
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 10) {
                HStack {
                    switch appData.currentDifficulty {
                    case .Easy:
                        Image(uiImage: UIImage(data: appData.imageData.easy[roundNum - 1])!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width/2, height: 200)
                    case .Medium:
                        Image(uiImage: UIImage(data: appData.imageData.medium[roundNum - 1])!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width/2, height: 200)
                    case .Hard:
                        Image(uiImage: UIImage(data: appData.imageData.hard[roundNum - 1])!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width/2, height: 200)
                    case .Extreme:
                        Image(uiImage: UIImage(data: appData.imageData.extreme[roundNum - 1])!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width/2, height: 200)
                    case .NotSelected:
                        Image(uiImage: UIImage(data: appData.imageData.easy[roundNum - 1])!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width/2, height: 200)
                    }
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
                    var currentImage: UIImage
                    switch appData.currentDifficulty {
                    case .Easy:
                        currentImage = UIImage(data: appData.imageData.easy[roundNum - 1])!
                    case .Medium:
                        currentImage = UIImage(data: appData.imageData.medium[roundNum - 1])!
                    case .Hard:
                        currentImage = UIImage(data: appData.imageData.hard[roundNum - 1])!
                    case .Extreme:
                        currentImage = UIImage(data: appData.imageData.extreme[roundNum - 1])!
                    case .NotSelected:
                        currentImage = UIImage(data: appData.imageData.easy[roundNum - 1])!
                    }
                    let distance = compareDrawings.compare(origImage: drawnImage.pngData()!, drawnImage: currentImage.pngData()!)
                    appData.gameData.rounds.append(Round(drawnImage: drawnImage.pngData()!, shownImage: currentImage.pngData()!, distance: distance))
                    
                    print(appData.gameData.rounds)
                })
            }, message: {
                Text("Once submitted, you may NOT edit your drawing anymore.")
            })
            
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
