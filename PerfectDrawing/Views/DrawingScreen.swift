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
    @ObservedObject var appData = AppData()
    @ObservedObject var storageManager = StorageManager()
    @ObservedObject var compareDrawings = CompareDrawings()
    
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
                    .preferredColorScheme(.light)
                    .foregroundColor(.white)
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
                    
                    var drawnImageLocalURL: URL
                    if let drawnURL = saveImage(image: drawnImage) {
                        drawnImageLocalURL = drawnURL
                    } else {
                        fatalError("Error in saving Drawn Image")
                    }
                    
                    var currentImageLocalURL: URL
                    if let currentURL = saveImage(image: currentImage) {
                        currentImageLocalURL = currentURL
                    } else {
                        fatalError("Error in saving Current Image")
                    }
                    
                    let distance = compareDrawings.compare(origImage: currentImageLocalURL, drawnImage: drawnImageLocalURL)
                                        
                    if distance != 420.0 {
                        appData.gameData.rounds.append(Round(roundNum: roundNum, drawnImage: drawnImageLocalURL, shownImage: currentImageLocalURL, distance: distance, rank: "", percentage: -1.0))
                        
                        if roundNum < 3 {
                            roundNum += 1
                            canvasView.drawing = PKDrawing()
                        } else {
                            for roundNum in 0..<3 {
                                let roundPercentage = determinePercentage(roundData: appData.gameData.rounds[roundNum])
                                let roundRank = determineRank(percentage: roundPercentage)
                                
                                appData.gameData.rounds[roundNum].percentage = roundPercentage
                                appData.gameData.rounds[roundNum].rank = roundRank
                            }
                            showResultsSheet = true
                        }
                    } else {
                        fatalError("Distance Value Error")
                    }
                })
            }, message: {
                Text("Once submitted, you may NOT edit your drawing anymore.")
            })
            .sheet(isPresented: $showResultsSheet) {
                ResultSheet().preferredColorScheme(.light)
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
        .onAppear() {
            print(appData.gameImages)
        }
    }
}

extension DrawingScreen {
    func saveImage(image: UIImage) -> URL? {
        guard let imageData = image.pngData() else {
            return nil
        }
        let baseURL = FileManager.default.temporaryDirectory
        let imageURL = baseURL.appendingPathComponent(UUID().uuidString).appendingPathExtension("png")
        do {
            try imageData.write(to: imageURL)
            return imageURL
        } catch {
            print("Error saving image to \(imageURL.path): \(error)")
            return nil
        }
    }
}

struct DrawingScreen_Previews: PreviewProvider {
    static var previews: some View {
        DrawingScreen()
    }
}
