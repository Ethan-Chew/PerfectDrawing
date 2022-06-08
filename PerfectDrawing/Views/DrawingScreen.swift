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
                            .border(.orange)
                    case .Medium:
                        Image(uiImage: UIImage(data: appData.imageData.medium[roundNum - 1])!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width/2, height: 200)
                            .border(.orange)
                    case .Hard:
                        Image(uiImage: UIImage(data: appData.imageData.hard[roundNum - 1])!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width/2, height: 200)
                            .border(.orange)
                    case .Extreme:
                        Image(uiImage: UIImage(data: appData.imageData.extreme[roundNum - 1])!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width/2, height: 200)
                            .border(.orange)
                    case .NotSelected:
                        Image(uiImage: UIImage(data: appData.imageData.easy[roundNum - 1])!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width/2, height: 200)
                            .border(.orange)
                    }
                    Spacer()
                    
                    //                    GeometryReader { leftColGeo in
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
                        .border(.orange)
                        
                        Button {
                            
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
                        .border(.orange)
                    }
                    //                    }
                    //                    .border(.yellow)
                    
                }
                .padding()
                .border(.green)
                
                Divider()
                    .frame(width: geometry.size.width/2)
                    .border(.red)
                
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
                    canvasView.drawing = PKDrawing()
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
