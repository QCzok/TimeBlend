

import SwiftUI

struct NewEventView: View {
    @Binding var events: [EventItem]
    @Environment(\.presentationMode) var presentationMode

    
    @State var newEventTitle = ""
    @State var newEventDescription = ""
    @State var newEventDate = Date()
    @State var newEventDurationHours = 0
    @State var newEventDurationMinutes = 0
    @State var newEventType: EventType = .work
    @State var newEventIconName = "briefcase" // Default icon name
    @State var newEventBackgroundColor = Color.blue // Default background color
    @State var newEventLocation = ""
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    TitleSelectorView(title: $newEventTitle)

                    DescriptionSelectorView(selectedDescription: $newEventDescription)
                    
                    DateSelectorView(date: $newEventDate)
                    
                    DurationSelectorView(selectedHours: $newEventDurationHours, selectedMinutes: $newEventDurationMinutes)

                    TypeSelectorView(type: $newEventType)
                    
                    LocationSelectorView(location: $newEventLocation)

                    // Save Button
                    Button(action: saveEvent) {
                        SaveSelectorsView()
                    }
                }
                .padding(.vertical, 24)
                .listRowSeparator(.hidden, edges: .bottom)
            }
        }
    }

    
    private func saveEvent() {
        let newEvent = EventItem(
            id: UUID(),
            title: newEventTitle,
            description: newEventDescription,
            date: newEventDate,
            hours: newEventDurationHours,
            minutes: newEventDurationMinutes,
            type: newEventType,
            location: newEventLocation,
            isMarked: false
        )

        events.append(newEvent)
        EventDataManager().saveEventItems(events)
        presentationMode.wrappedValue.dismiss()
    }
}
