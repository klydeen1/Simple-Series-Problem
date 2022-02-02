//
//  SimpleSeries.swift
//  Simple-Series-Problem
//
//  Created by Katelyn Lydeen on 2/1/22.
//

import Foundation
import SwiftUI

class SimpleSeries: NSObject, ObservableObject {
    // Initialize values and text for N, the number of terms in the sum and for the
    // three methods of finding the sum
    var N:Int = 1
    @Published var nString = ""
    @Published var sUp = 0.0
    @Published var sDown = 0.0
    @Published var sUpText = ""
    @Published var sDownText = ""
    
    // Set the calculate button to enabled
    @Published var enableButton = true
    
    /// initWithN
    /// Initializes a finite sum with N terms using the three different expressions for finding the sum
    /// - Parameter N: the number of terms for the sum
    /// returns true to indicate the function has finished running
    func initWithN(passedN: Int) async -> Bool {
        N = passedN
        let _ = await withTaskGroup(of: Void.self) { taskGroup in
            taskGroup.addTask {let _ = await self.calculateSUp(N: self.N)}
            taskGroup.addTask {let _ = await self.calculateSDown(N: self.N)}
        }
        
        await setButtonEnable(state: true)
        
        return true
    }
    
    /// calculateSUp
    /// Solves the finite sum using the formula listed in the method
    /// - Parameter N: (int), the number of terms to use in calculating the sum
    /// returns calculatedSUp, the value of the sum
    func calculateSUp(N: Int) async -> Double {
        //    N
        //    __     1
        //   \      ----
        //   /__     n
        //  n = 1
        
        var calculatedSUp = 0.0
        var currentTerm = 0.0
        let lowerIndex = 1
        
        for n in stride(from:lowerIndex, through:N, by: 1) {
            currentTerm = 1 / Double(n)
            calculatedSUp += currentTerm
        }

        let newSUpText = String(calculatedSUp)
        
        await updateSUp(sUpTextString: newSUpText)
        await newSUpValue(sUpValue: calculatedSUp)
        
        return calculatedSUp
    }
    
    /// calculateSUpSync
    /// Synced version of calculateSUp. Used for avoiding errors in plotting these data
    func calculateSUpSync(N: Int) -> Double {
        var calculatedSUp = 0.0
        var currentTerm = 0.0
        let lowerIndex = 1
        
        for n in stride(from:lowerIndex, through:N, by: 1) {
            currentTerm = 1 / Double(n)
            calculatedSUp += currentTerm
        }
        return calculatedSUp
    }
    
    /// calculateSDown
    /// Solves the finite sum using the formula listed in the method
    /// - Parameter N: (int), the number of terms to use in calculating the sum
    /// returns calculatedSDown, the value of the sum
    func calculateSDown(N: Int) async -> Double {
        //    1
        //    __     1
        //   \      ----
        //   /__     n
        //  n = N
        
        var calculatedSDown = 0.0
        var currentTerm = 0.0
        let lowerIndex = 1
        
        // Summation
        for n in stride(from:N, through:lowerIndex, by: -1) {
            currentTerm = 1 / Double(n)
            calculatedSDown += currentTerm
        }
        
        let newSDownText = String(calculatedSDown)
        
        await updateSDown(sDownTextString: newSDownText)
        await newSDownValue(sDownValue: calculatedSDown)
        
        return calculatedSDown
    }
    
    /// calculateSDownSync
    /// Synced version of calculateSDown used for plotting
    func calculateSDownSync(N: Int) -> Double {
        var calculatedSDown = 0.0
        var currentTerm = 0.0
        let lowerIndex = 1
        
        for n in stride(from:N, through:lowerIndex, by: -1) {
            currentTerm = 1 / Double(n)
            calculatedSDown += currentTerm
        }
        
        return calculatedSDown
    }
    
    /// calculateRelError
    /// Solves for the relative error of the sum sUp assuming s3 is the precise value
    /// | sUp - sDown  | / (sUp + sDown)
    /// - Parameter N: the number of terms to use in calculating the sum
    /// returns relError, the calculated relative error
    func calculateRelError(passedN: Int) -> Double {
        let n = passedN
        var relError = 0.0
        let sUp = self.calculateSUpSync(N: n)
        let sDown = self.calculateSDownSync(N: n)
        relError = abs(sUp - sDown) / (sUp + sDown)
        
        return relError
    }
    
    /// setButtonEnable
    /// Toggles the state of the calculate button
    /// - Parameter state: Boolean indicating whether the button should be enabled or not
    @MainActor func setButtonEnable(state: Bool) {
        if state {
            Task.init {
                await MainActor.run {
                    self.enableButton = true
                }
            }
        }
        else{
            Task.init {
                await MainActor.run {
                    self.enableButton = false
                }
            }
        }

    }
    
    /// updateSUp
    /// Executes on the main thread to update the text that gives the value of sUp, the sum preformed up
    /// - Parameter sUpTextString: Text describing the value of sUp
    @MainActor func updateSUp(sUpTextString: String){
        sUpText = sUpTextString
    }
    
    /// newSUpValue
    /// Updates the value of sUp, the sum preformed up
    /// - Parameter sUpValue: Double describing the value of sUp
    @MainActor func newSUpValue(sUpValue: Double){
        self.sUp = sUpValue
    }
    
    /// Same as above for the sum preformed down
    @MainActor func updateSDown(sDownTextString: String){sDownText = sDownTextString}
    @MainActor func newSDownValue(sDownValue: Double){self.sDown = sDownValue}
    
}
