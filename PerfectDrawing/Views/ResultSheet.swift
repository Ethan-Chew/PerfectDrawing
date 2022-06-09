//
//  ResultSheet.swift
//  PerfectDrawing
//
//  Created by Ethan Chew on 8/6/22.
//

import SwiftUI

struct ResultSheet: View {
    
    // Classes
    let appData = AppData()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                Text("Results")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                ForEach(appData.gameData.rounds) { round in
                    HStack {
                        Text(round.rank)
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
