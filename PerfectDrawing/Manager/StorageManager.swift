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
    
    func listImages() {
        let imageTypes = ["easy", "medium", "hard", "extreme"]
        
        for type in imageTypes {
            let storageReference = storage.reference().child(type)
            
            storageReference.listAll { (res, err) in
                if let err = err {
                    print("Error in Listing Files in \(type), \(err.localizedDescription)")
                }

                for item in res!.items {
                    print("\(type), \(item)")
                }
            }
        }
    }
    
    func getRelatedImage(imageType: String) {
        let storageReference = storage.reference().child(imageType)
        var imageArr: [UIImage] = []
        
        storageReference.listAll { (res, err) in
            if let err = err {
                print("Error in getting \(imageType) images, failed with: \(err.localizedDescription)")
            }
            
            for item in res!.items {
                let imageRef = self.storage.reference(forURL: String(describing: item))
                imageRef.getData(maxSize: (1 * 1024 * 1024)) { (data, err) in
                    if let err = err {
                        print("An Error Occurred: \(err.localizedDescription)")
                    }
                    
                    if let img = data {
                        let image: UIImage! = UIImage(data: img)
                        imageArr.append(image)
                    }
                }
            }
        }
        appData.difficultyImage = imageArr
    }
}
