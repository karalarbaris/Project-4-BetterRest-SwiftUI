//
//  ContentView.swift
//  Project-4-BetterRest-SwiftUI
//
//  Created by Baris Karalar on 12.06.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date()
    
    var body: some View {

        VStack {
            
            Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                Text("\(sleepAmount, specifier: "%g")")

            }
                
            DatePicker("Please enter a date", selection: $wakeUp, in: Date()...)
                .labelsHidden()
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
