//
//  HomeScreen.swift
//  PerfectDrawing
//
//  Created by Ethan Chew on 5/6/22.
//

import Foundation
import SwiftUI

struct HomeScreen: View {
    
    // Variables
    @State var currentHardness: GameType = .NotSelected
    @State var isStartAllowed: Bool = true
    
    // Classes
    let storageManager = StorageManager()
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                // App Name
                HStack {
                    VStack(alignment: .leading) {
                        Text("PerfectDrawing")
                            .font(.system(size: 40, weight: .bold))
                        Text("How Perfect can your drawing be?")
                            .font(.title)
                            .foregroundColor(Color(UIColor(named: "SecondaryColour")!))
                    }
                    Spacer()
                }
                .padding()
                .padding(.leading, 20)
                
                Spacer()
                
                // Instructions Text
                HStack {
                    VStack(alignment: .leading) {
                        // Game Settings Text
                        VStack(alignment: .leading) {
                            Text("Game Instructions")
                                .bold()
                                .font(.largeTitle)
                            Text("How do I play?")
                                .font(.title2)
                        }
                        .padding(.bottom, 8)
                        Text("Well, you will **need an Apple Pencil (or any iPadOS Compatible Stylus)** to be paired to this iPad!")
                            .padding(.bottom, 1)
                        Text("Firstly, **Pick a Difficulty** for your Game and Simply **Press 'Start Game'**!")
                        Text("Secondly, ")
                    }
                    Spacer()
                }
                .padding()
                .padding(.leading, 20)
                                
                // App Settings
                HStack(alignment: .center) {
                    // Left Section
                    VStack(alignment: .leading) {
                        // Game Settings Text
                        VStack(alignment: .leading) {
                            Text("Game Settings")
                                .bold()
                                .font(.largeTitle)
                            Text("Select the difficulty of your game!")
                                .font(.title2)
                        }
                        
                        // Easy Button
                        Button {
                            currentHardness = .Easy
                            isStartAllowed = true
                        } label: {
                            Text("Easy")
                                .font(.title2)
                                .bold()
                                .frame(width: geometry.size.width/2, height: 30)
                                .padding()
                                .background(.green)
                                .foregroundColor(.white)
                                .cornerRadius(15)
                        }
                        
                        // Medium Button
                        Button {
                            currentHardness = .Medium
                            isStartAllowed = true
                        } label: {
                            Text("Medium")
                                .font(.title2)
                                .bold()
                                .frame(width: geometry.size.width/2, height: 30)
                                .padding()
                                .background(Color(UIColor(named: "MediumYellow")!))
                                .foregroundColor(.white)
                                .cornerRadius(15)
                        }
                        
                        // Hard Button
                        Button {
                            currentHardness = .Hard
                            isStartAllowed = true
                        } label: {
                            Text("Hard")
                                .font(.title2)
                                .bold()
                                .frame(width: geometry.size.width/2, height: 30)
                                .padding()
                                .background(.red)
                                .foregroundColor(.white)
                                .cornerRadius(15)
                        }
                        
                        // Extreme Button
                        Button {
                            currentHardness = .Extreme
                            isStartAllowed = true
                        } label: {
                            Text("Extreme")
                                .font(.title2)
                                .bold()
                                .frame(width: geometry.size.width/2, height: 30)
                                .padding()
                                .background(Color(UIColor(named: "ExtremeRed")!))
                                .foregroundColor(.white)
                                .cornerRadius(15)
                        }
                    }
                    Spacer()
                    
                    // Right Section
                    VStack(alignment: .leading, spacing: 5) {
                        Text("**Currently Selected:**")
                            .font(.title2)
                        Text(String(describing: currentHardness))
                            .font(.title3)
                    }
                    Spacer()
                }
                .padding()
                .padding(.leading, 20)
                
                Spacer()
                
                // Start Game Button
                Button {
                    if isStartAllowed {
                        storageManager.getRelatedImage(imageType: String(describing: currentHardness).lowercased())
                    }
                } label: {
                    Text("Start Game")
                        .font(.title2)
                        .bold()
                        .frame(width: geometry.size.width-90, height: 30)
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .disabled(isStartAllowed)
                }
                
                Spacer()
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeScreen()
        }
    }
}
