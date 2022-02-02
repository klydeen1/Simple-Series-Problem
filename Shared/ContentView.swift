//
//  ContentView.swift
//  Shared
//
//  Created by Katelyn Lydeen on 2/1/22.
//

import SwiftUI

struct ContentView: View {
    // Initialize an instance of the FiniteSum class called sumModel
    @ObservedObject private var sumModel = SimpleSeries()
    
    // Initialize a default value for N, the number of terms in the sum
    @State var nString = "5"
    
    var body: some View {
        // Display outputs on the UI
        VStack {
            HStack {
                VStack {
                    Text("N, the number of terms")
                        .padding(.top)
                        .padding(.bottom, 0)
                    TextField("Enter the number of terms N", text: $nString, onCommit: {Task.init {await self.calculateSums()}})
                        .padding(.horizontal)
                        .frame(width: 100)
                        .padding(.top, 0)
                        .padding(.bottom, 30)
                }
                VStack{
                    Text("Sum S1")
                        .padding(.top)
                        .padding(.bottom, 0)
                    TextField("", text: $sumModel.sUpText)
                        .padding(.horizontal)
                        .frame(width: 100)
                        .padding(.top, 0)
                        .padding(.bottom,30)
                }
                VStack{
                    Text("Sum S2")
                        .padding(.top)
                        .padding(.bottom, 0)
                    TextField("", text: $sumModel.sDownText)
                        .padding(.horizontal)
                        .frame(width: 100)
                        .padding(.top, 0)
                        .padding(.bottom,30)
                }
            
            // Add calculate button that will run the calculations once pressed
            Button("Calculate", action: {Task.init {await calculateSums()}})
                    .padding(.top)
                    .padding(.top)
                    .padding(.bottom)
                    .padding()
                    .disabled(sumModel.enableButton == false)
            }
        }
    }
    
    func calculateSums() async {
        sumModel.setButtonEnable(state: false)
        let _ : Bool = await sumModel.initWithN(passedN: Int(nString)!)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
