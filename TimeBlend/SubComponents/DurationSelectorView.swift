//
//  DurationView.swift
//  TimeBlend
//
//  Created by Payback on 26.07.23.
//

import SwiftUI

struct DurationSelectorView: View {
    
    @Binding var selectedHours: Int
    @Binding var selectedMinutes: Int
    
    var body: some View {
        VStack {
            HStack{
                Image(systemName: "clock.fill")
                    .foregroundColor(.blue)
                Text("Event Duration:")
                    .foregroundColor(.primary)
                Spacer()
            }
            VStack{
                HStack{
                    Text("\(selectedHours)h")
                    Stepper(value: $selectedHours, in: 0...24) {
                    }
                }
                
                HStack {
                    Text("\(selectedMinutes)m")
                    Stepper(value: $selectedMinutes, in: 0...59, step: 5) {
                    }
                }
            }
        }
    }
}
