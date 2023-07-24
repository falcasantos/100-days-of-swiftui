//
//  ContentView.swift
//  Challenge 1
//
//  Created by Robert Falcasantos on 2023-07-24.
//

import SwiftUI

enum TimeUnit: String {
    case seconds = "seconds"
    case minutes = "minutes"
    case hours = "hours"
    case days = "days"
}

enum SecondsMultiplier: Double {
    case days = 86_400
    case hours = 3600
    case minutes = 60
}
func convertTime(time: Double, inputUnit: String, outputUnit: String) -> Double {
    let inputTime: Double
    switch inputUnit {
    case TimeUnit.days.rawValue: inputTime = time * SecondsMultiplier.days.rawValue
    case TimeUnit.hours.rawValue: inputTime = time * SecondsMultiplier.hours.rawValue
    case TimeUnit.minutes.rawValue: inputTime = time * SecondsMultiplier.minutes.rawValue
    default: inputTime = time
    }
    switch outputUnit {
    case TimeUnit.days.rawValue: return inputTime / SecondsMultiplier.days.rawValue
    case TimeUnit.hours.rawValue: return inputTime / SecondsMultiplier.hours.rawValue
    case TimeUnit.minutes.rawValue: return inputTime / SecondsMultiplier.minutes.rawValue
    default: return inputTime
    }
}

struct ContentView: View {
    let units = [TimeUnit.seconds.rawValue, TimeUnit.minutes.rawValue,
                 TimeUnit.hours.rawValue, TimeUnit.days.rawValue]
    @State private var inputNumber = 0.0
    @State private var inputUnit = TimeUnit.seconds.rawValue
    @State private var outputUnit = TimeUnit.minutes.rawValue
    @FocusState private var inputIsFocused: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Time to convert", value: $inputNumber, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                    
                    Picker("Unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text("\($0)")
                        }
                    }.pickerStyle(.segmented)
                    
                } header: {
                    Text("Time to convert")
                }
                
                Section {
                    Text("\(convertTime(time: inputNumber, inputUnit: inputUnit, outputUnit: outputUnit).formatted())")
                    
                    Picker("Unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text("\($0)")
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Converted time")
                }
            }
            .navigationTitle("Time Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
