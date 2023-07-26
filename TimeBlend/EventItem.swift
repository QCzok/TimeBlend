//
//  EventItem.swift
//  TimeBlend
//
//  Created by Payback on 24.07.23.
//

import Foundation

struct EventItem: Codable, Hashable {
    var id: UUID?
    var title: String
    var description: String
    var date: Date
    var duration: Double
    var type: EventType
}

enum EventType: String, Codable {
    case privat = "private"
    case work = "work"
}
