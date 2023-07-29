//
//  TimeCalculator.swift
//  TimeBlend
//
//  Created by Payback on 29.07.23.
//

import Foundation

class TimeCalculator {
    
    func timeLeft(from date: Date) -> String {
        let currentTime = Date()
        let timeLeft = date.timeIntervalSince(currentTime)
        
        if timeLeft < 0 {
            return "Event has started"
        } else {
            let components = Calendar.current.dateComponents([.day, .hour, .minute], from: currentTime, to: date)
            let days = components.day ?? 0
            let hours = components.hour ?? 0
            let minutes = components.minute ?? 0
            
            if days > 0 {
                return "\(days) day\(days == 1 ? "" : "s") left"
            } else {
                if hours > 0 {
                    return "\(hours) hr \(minutes) min left"
                } else {
                    return "\(minutes) min left"
                }
            }
        }
    }
}
