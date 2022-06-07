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
    @State var isNotSel: Bool = true
    @State var selection: Int? = nil
    @State var isNavigationBarHidden: Bool = true
    
    // Classes
    let storageManager = StorageManager()
    let appData = AppData()
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
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
                    .padding(.top, 20)
                    .padding(.leading, 20)
                    .padding(.bottom, 40)
                    
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
                    VStack(alignment: .leading) {
                        // Game Settings Text
                        VStack(alignment: .leading) {
                            Text("Game Settings")
                                .bold()
                                .font(.largeTitle)
                            Text("Select the difficulty of your game!")
                                .font(.title2)
                        }
                        
                        // Buttons
                        HStack {
                            // Left Section
                            VStack(alignment: .center) {
                                // Easy Button
                                Button {
                                    appData.currentDifficulty = .Easy
                                    isNotSel = false
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
                                    appData.currentDifficulty = .Medium
                                    isNotSel = false
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
                                    appData.currentDifficulty = .Hard
                                    isNotSel = false
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
                                    appData.currentDifficulty = .Extreme
                                    isNotSel = false
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
                                Spacer()
                            }
                            
                            Spacer()
                            
                            // Right Section
                            VStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("**Currently Selected:**")
                                        .font(.title2)
                                    Text(String(describing: appData.currentDifficulty) == "NotSelected" ? "Not Selected" : String(describing: appData.currentDifficulty))
                                        .font(.title3)
                                }
                                .padding()
                                .background(Color(UIColor(named: "LightGrey")!))
                                .cornerRadius(15)
                                
                                Spacer()
                            }
                            
                            Spacer()
                        }
                    }
                    .padding()
                    .padding(.leading, 20)
                    
                    Spacer()
                    
                    // Start Game Button
                    NavigationLink(destination: DrawingScreen()) {
                        Text("Start Game\(isNotSel ? " Disabled" : "")")
                            .font(.title2)
                            .bold()
                            .frame(width: abs(geometry.size.width-90), height: 30)
                            .padding()
                            .background(isNotSel ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }
                    .disabled(isNotSel)
                    .padding()
                    .padding(.bottom, 30)
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                }
                .navigationBarTitle("Home")
                .navigationBarHidden(self.isNavigationBarHidden)

                .onAppear {
                    self.isNavigationBarHidden = true
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeScreen()
                .previewInterfaceOrientation(.portrait)
        }
    }
}
