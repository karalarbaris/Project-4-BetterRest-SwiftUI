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
    @State private var coffeeAmount = 1
    
    var body: some View {
        
        NavigationView {
            VStack {
                Text("When would you like to wake up?")
                    .font(.headline)
                DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                
                Text("Desired amount of sleep")
                    .font(.headline)
                Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                    Text("\(sleepAmount, specifier: "%g") hours")
                }
                
                Text("Daily coffee intake")
                    .font(.headline)
                Stepper(value: $coffeeAmount, in: 0...20) {
                    if coffeeAmount == 1 {
                        Text("\(coffeeAmount) cup")
                    } else {
                        Text("\(coffeeAmount) cups")
                    }
                }
                
            }
            .navigationBarTitle("BetterRest")
            .navigationBarItems(trailing:
                                    Button(action: calculateBedTime) {
                                        Text("Calculate")
                                    }
            )
        }

        
        
        
        //        var components = DateComponents()
        //        components.hour = 8
        //        components.minute = 0
        //        let date = Calendar.current.date(from: components) ?? Date()
        
        ///////////////
        
        //        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        //        let hour = components.hour ?? 0
        //        let minute = components.minute ?? 0
        //        print("\(hour):\(minute)")
        
        ///////////////
        
        //        let formatter = DateFormatter()
        //        formatter.timeStyle = .short
        //        let dateString = formatter.string(from: Date())
        //        print("\(dateString)")
        
        //        return DatePicker("Please enter a date", selection: $wakeUp, in: Date()...)
        //            .labelsHidden()
        
        
        //        VStack {
        //
        //            Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
        //                Text("\(sleepAmount, specifier: "%g")")
        //
        //            }
        //
        //            DatePicker("Please enter a date", selection: $wakeUp, in: Date()...)
        //                .labelsHidden()
        //
        //        }
        
    }
    
    func calculateBedTime() {
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
