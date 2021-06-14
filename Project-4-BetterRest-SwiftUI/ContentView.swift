//
//  ContentView.swift
//  Project-4-BetterRest-SwiftUI
//
//  Created by Baris Karalar on 12.06.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 5
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    var body: some View {
        
        NavigationView {
            Form {
                
                Section(header: Text("When would you like to wake up?")) {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                Section(header: Text("Desired amount of sleep")) {
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                
                Section(header: Text("Daily coffee intake")) {
                    
                    Picker("How many cups", selection: $coffeeAmount) {
                        ForEach(0 ..< 21) {
                            Text($0 > 1 ? "\($0) cups" : "\($0) cup")

                        }
                        
                    }
                    //                    Stepper(value: $coffeeAmount, in: 0...20) {
                    //                        if coffeeAmount == 1 {
                    //                            Text("\(coffeeAmount) cup")
                    //                        } else {
                    //                            Text("\(coffeeAmount) cups")
                    //                        }
                    //                    }
                }
                
                
            }
            .navigationBarTitle("BetterRest")
            .navigationBarItems(trailing:
                                    Button(action: calculateBedTime) {
                                        Text("Calculate")
                                    }
            )
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Okay")))
            }
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
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            alertMessage = formatter.string(from: sleepTime)
            alertTitle = "Your ideal bedtime is..."
            
            
        } catch  {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        showingAlert = true
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
