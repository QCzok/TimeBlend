//
//  TimeBlendTests.swift
//  TimeBlendTests
//
//  Created by Payback on 24.07.23.
//

import XCTest
@testable import TimeBlend

final class TimeBlendTests: XCTestCase {
    
    var eventRow: EventRow!

    override func setUpWithError() throws {
        super.setUp()
        eventRow = EventRow(item: EventItem(id: UUID(), title: "Title", description: "Description", date: Date.now, hours: 1, minutes: 0, type: EventType.privat, location: "Location", isMarked: false))
         
    }

    override func tearDownWithError() throws {
        eventRow = nil
        super.tearDown()
    }

    func testTimeLeftText() {
        let currentDate = Date()
            
            let testCases: [(Date, String)] = [
                (currentDate.addingTimeInterval(61), "1 min left"),
                (currentDate.addingTimeInterval(3601), "1 hr 0 min left"),
                (currentDate.addingTimeInterval(86401), "1 day left"),
                (currentDate.addingTimeInterval(-60), "Event has started"),
            ]
            
            for (date, expectedText) in testCases {
                eventRow.item.date = date
                eventRow.timeLeftText = TimeCalculator().timeLeft(from: currentDate)
                XCTAssertEqual(TimeCalculator().timeLeft(from: date), expectedText)
            }
        }
}
