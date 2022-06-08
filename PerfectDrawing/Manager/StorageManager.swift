//
//  StorageManager.swift
//  PerfectDrawing
//
//  Created by Ethan Chew on 5/6/22.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseStorage

public class StorageManager: ObservableObject {
    let storage = Storage.storage()
    let appData = AppData()
    
    var imageData = ImageData(easy: [], medium: [], hard: [], extreme: [])
    
    func reloadImages() {
        let imageTypes = ["easy", "medium", "hard", "extreme"]
        
        appData.imageData = imageData // Reset Data
        
        for type in imageTypes {
            let storageReference = storage.reference().child(type)
            
            storageReference.listAll { (res, err) in
                if let err = err {
                    print("Error in Listing Files in \(type), \(err.localizedDescription)")
                }

                for item in res!.items {
                    let imageRef = self.storage.reference(forURL: String(describing: item))
                    imageRef.getData(maxSize: (1 * 1024 * 1024)) { (data, err) in
                        if let err = err {
                            print("An Error Occurred: \(err.localizedDescription)")
                        }
                                                
                        if let img = data {
                            switch type {
                            case "easy":
                                self.appData.imageData.easy.append(img)
                            case "medium":
                                self.appData.imageData.medium.append(img)
                            case "hard":
                                self.appData.imageData.hard.append(img)
                            case "extreme":
                                self.appData.imageData.extreme.append(img)
                            default:
                                break
                            }
                        }
                    }
                }
            }
        }
    }
}
