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
    func featureprintObservationForImage(atURL url: URL) -> VNFeaturePrintObservation? {
        let requestHandler = VNImageRequestHandler(url: url, options: [:])
        let request = VNGenerateImageFeaturePrintRequest()
        do {
            try requestHandler.perform([request])
            return request.results?.first as? VNFeaturePrintObservation
        } catch {
            print("Vision error: \(error)")
            return nil
        }
    }
    
    func compare(origImage: URL, drawnImage: URL) -> Float {
        let oImgObservation = featureprintObservationForImage(atURL: origImage) // nil
        let dImgObservation = featureprintObservationForImage(atURL: drawnImage) // nil
        
        if let oImgObservation = oImgObservation {
            if let dImgObservation = dImgObservation {
                var distance: Float = 1
                
                do {
                    try dImgObservation.computeDistance(&distance, to: oImgObservation)
                } catch {
                    fatalError("Failed to Compute Distance")
                }
                
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
