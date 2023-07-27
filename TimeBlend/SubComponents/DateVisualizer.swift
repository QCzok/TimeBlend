//
//  DateVisualizer.swift
//  TimeBlend
//
//  Created by Payback on 27.07.23.
//

import SwiftUI

struct DateVisualizer: View {
    
    var date: Date
    
    public var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        return dateFormatter.string(from: date)
    }
    
    var body: some View {
        Text(formattedDate)
            .font(.subheadline)
    }
}
