//
//  CompareDrawings.swift
//  PerfectDrawing
//
//  Created by Ethan Chew on 7/6/22.
//

import Foundation
import UIKit
import Vision
import CoreImage
import CoreImage.CIFilterBuiltins

public class CompareDrawings: ObservableObject {
    func featureprintObservationForImage(data: Data) -> VNFeaturePrintObservation? {
        
        let requestHandler = VNImageRequestHandler(data: data, options: [:])
        let request = VNGenerateImageFeaturePrintRequest()
        do {
            try requestHandler.perform([request])
            return request.results?.first as? VNFeaturePrintObservation
        } catch {
            print("Vision error: \(error)")
            return nil
        }
    }
    
    func compare(origImage: Data, drawnImage: Data) -> Float {
        let oImgObservation = featureprintObservationForImage(data: origImage) // nil
        let dImgObservation = featureprintObservationForImage(data: drawnImage) // nil
        
        if let oImgObservation = oImgObservation {
            if let dImgObservation = dImgObservation {
                var distance: Float = 1
                
                do {
                    try oImgObservation.computeDistance(&distance, to: dImgObservation)
                } catch {
                    fatalError("Failed to Compute Distance")
                }
                
                print(distance)
                return distance
            } else {
                print("Drawn Image Observation found Nil")
            }
        } else {
            print("Original Image Observation found Nil")
        }
        return 404.0
    }
}

