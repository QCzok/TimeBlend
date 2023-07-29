import XCTest
@testable import TimeBlend

final class TimeBlendTests: XCTestCase {
    var events: [EventItem] = []
    var sut: EventItemList!

    override func setUpWithError() throws {
        try super.setUpWithError()
        events = [
            EventItem(id: UUID(), title: "Title1", description: "Descroption1", date: Date.now, hours: 1, minutes: 2, type: EventType.privat, location: "Location1", isMarked: false),
            EventItem(id: UUID(), title: "Title2", description: "Descroption2", date: Date.now, hours: 2, minutes: 3, type: EventType.privat, location: "Location2", isMarked: false),
            EventItem(id: UUID(), title: "Title3", description: "Descroption3", date: Date.now, hours: 3, minutes: 4, type: EventType.privat, location: "Location3", isMarked: true)
        ]
        sut = EventItemList(events: events)
    }

    override func tearDownWithError() throws {
        sut = nil
        events.removeAll()
        try super.tearDownWithError()
    }

    func testFilteredEvents_All() throws {
        // Given
        sut.selectedFilter = .all

        // When
        let filteredEvents = sut.filteredEvents

        // Then
        XCTAssertEqual(filteredEvents.count, events.count, "Filtered events should contain all events.")
    }

    func testFilteredEvents_PrivateEvent() throws {
        // Given
        sut.selectedFilter = .privateEvent

        // When
        let filteredEvents = sut.filteredEvents

        // Then
        let privateEvents = events.filter { $0.type == EventType.privat }
        XCTAssertEqual(filteredEvents.count, privateEvents.count, "Filtered events should contain only private events.")
    }

    func testFilteredEvents_Work() throws {
        // Given
        sut.selectedFilter = .work

        // When
        let filteredEvents = sut.filteredEvents

        // Then
        let workEvents = events.filter { $0.type == .work }
        XCTAssertEqual(filteredEvents.count, workEvents.count, "Filtered events should contain only work events.")
    }

    func testSaveAndLoadEventsToUserDefaults() throws {
        // Given
        let userDefaults = UserDefaults.standard

        // When
        sut.saveEventsToUserDefaults()

        // Then
        if let data = userDefaults.data(forKey: "savedEvents"),
           let savedEvents = try? JSONDecoder().decode([EventItem].self, from: data) {
            XCTAssertEqual(savedEvents, events, "Saved events should match the original events.")
        } else {
            XCTFail("Failed to load saved events from UserDefaults.")
        }
    }

    func testDeleteEvent() throws {
        // Given
        let initialCount = events.count
        let indexToRemove = 1

        // When
        sut.deleteEvent(at: IndexSet(integer: indexToRemove))

        // Then
        XCTAssertEqual(sut.events.count, initialCount - 1, "After deleting an event, the events count should decrease by 1.")
        XCTAssertFalse(sut.events.contains(events[indexToRemove]), "Deleted event should no longer be present in the events array.")
    }

    func testMoveEvent() throws {
        // Given
        let initialOrder = events
        let sourceIndex = 0
        let destinationIndex = events.count - 1

        // When
        sut.moveEvent(from: IndexSet(integer: sourceIndex), to: destinationIndex)

        // Then
        XCTAssertEqual(sut.events[destinationIndex], initialOrder[sourceIndex], "After moving an event, it should be at the destination index.")
    }
}
