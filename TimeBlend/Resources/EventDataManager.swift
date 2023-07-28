//
//  EventDataManager.swift
//  TimeBlend
//
//  Created by Payback on 28.07.23.
//

import Foundation

class EventDataManager {
    static let shared = EventDataManager()
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "eventItems"
    
    func saveEventItems(_ eventItems: [EventItem]) {
        if let encodedData = try? encoder.encode(eventItems) {
            UserDefaults.standard.set(encodedData, forKey: key)
        }
    }
    
    func loadEventItems() -> [EventItem] {
        if let encodedData = UserDefaults.standard.data(forKey: key),
           let eventItems = try? decoder.decode([EventItem].self, from: encodedData) {
            return eventItems
        }
        return [] // Return an empty array if no data is found
    }
}
