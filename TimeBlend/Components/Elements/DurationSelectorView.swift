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
            HStack {
                Image(systemName: "clock.fill")
                    .foregroundColor(.blue)
                    .font(.title2)

                Text("Duration:")
                    .foregroundColor(.primary)
                    .font(.headline)

                Picker("", selection: $selectedHours) {
                    ForEach(0..<25, id: \.self) { hour in
                        Text("\(hour)h")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 60,  height: 100)

                Picker("", selection: $selectedMinutes) {
                    ForEach(0..<60, id: \.self) { minute in
                        Text("\(minute)m")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 60, height: 100) // Adjust the width of the minutes picker
            }
            .cornerRadius(10)
        }
    }
}
