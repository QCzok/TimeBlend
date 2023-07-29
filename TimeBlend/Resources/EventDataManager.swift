
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
    
    func saveEventItem(event: EventItem) {
        // Get the current saved events from UserDefaults (if any)
        if let data = UserDefaults.standard.data(forKey: key) {
            do {
                // Decode the data into an array of EventItem objects
                var events = try JSONDecoder().decode([EventItem].self, from: data)
                
                // Find the index of the edited event in the array
                if let index = events.firstIndex(where: { $0.id == event.id }) {
                    // Update the event in the array with the edited event
                    events[index] = event
                    
                    // Encode the updated array of events and save it to UserDefaults
                    let updatedData = try JSONEncoder().encode(events)
                    UserDefaults.standard.set(updatedData, forKey: key)
                }
            } catch {
                print("Error decoding or encoding events:", error)
            }
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
