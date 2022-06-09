//
//  ResultSheet.swift
//  PerfectDrawing
//
//  Created by Ethan Chew on 8/6/22.
//

import SwiftUI

struct ResultSheet: View {
    
    // Classes
    @ObservedObject var appData = AppData()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                Text("Results")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                Spacer()
                ForEach(appData.gameData.rounds) { round in
                    VStack(alignment: .leading) {
                        // Rank and Accuracy
                        HStack {
                            Text(round.rank)
                                .font(.system(size: 40, weight: .bold))
                                .fontWeight(.bold)
                                .foregroundColor(Color(uiColor: UIColor(named: "Rank \(round.rank.first!)")!))
                            Text("\(String(round.percentage))% Accuracy")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(uiColor: UIColor(named: "DarkGrey")!))
                        }
                        
                        // Original Image and Drawn Image
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Original Image")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                Image(uiImage: UIImage(data: round.shownImage)!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 300, height: 200)
                                    .border(.black)
                                    .cornerRadius(10)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                Text("Drawn Image")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                Image(uiImage: UIImage(data: round.drawnImage)!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 300, height: 200)
                                    .border(.black)
                                    .cornerRadius(10)
                            }
                            
                            Spacer()
                        }
                    }
                }
                Spacer()
            }
        }
        .onAppear() {
            print(appData.gameData)
        }
    }
}

struct ResultSheet_Previews: PreviewProvider {
    static var previews: some View {
        ResultSheet()
    }
}
