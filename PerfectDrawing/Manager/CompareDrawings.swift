//
//  CompareDrawings.swift
//  PerfectDrawing
//
//  Created by Ethan Chew on 7/6/22.
//

import Foundation
import UIKit
import Vision

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
    
    func compare() {
        
    }
}
