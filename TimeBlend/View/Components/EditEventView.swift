
import SwiftUI

struct EditEventView: View {
        @Environment(\.presentationMode) var presentationMode
        @Binding var event: EventItem
        
        // Use temporary variables to hold the edited values
        @State private var editedTitle: String
        @State private var editedDescription: String
        @State private var editedDate: Date
        @State private var editedHours: Int
        @State private var editedMinutes: Int
        @State private var editedType: EventType
        @State private var editedLocation: String
        
        init(event: Binding<EventItem>) {
            _event = event
            let initialEvent = event.wrappedValue
            _editedTitle = State(initialValue: initialEvent.title)
            _editedDescription = State(initialValue: initialEvent.description)
            _editedDate = State(initialValue: initialEvent.date)
            _editedHours = State(initialValue: initialEvent.hours)
            _editedMinutes = State(initialValue: initialEvent.minutes)
            _editedType = State(initialValue: initialEvent.type)
            _editedLocation = State(initialValue: initialEvent.location)
        }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    TitleSelectorView(title: $editedTitle)

                    DescriptionSelectorView(selectedDescription: $editedDescription)

                    DateSelectorView(date: $editedDate)

                    DurationSelectorView(selectedHours: $editedHours, selectedMinutes: $editedMinutes)

                    TypeSelectorView(type: $editedType)
                    
                    LocationSelectorView(location: $editedLocation)

                    // Save Button
                    Button(action: saveEvent) {
                        SaveSelectorsView()
                    }
                }
                .padding(.vertical, 24)
                .listRowSeparator(.hidden, edges: .bottom)
            }
            .navigationBarTitle("Edit Event", displayMode: .inline)
        }
    }
    
    private func saveEvent() {
        // Update the original event with the edited values when the "Save" button is tapped
        $event.wrappedValue.title = editedTitle
        $event.wrappedValue.description = editedDescription
        $event.wrappedValue.date = editedDate
        $event.wrappedValue.hours = editedHours
        $event.wrappedValue.minutes = editedMinutes
        $event.wrappedValue.type = editedType
        $event.wrappedValue.location = editedLocation
        
        EventDataManager().saveEventItem(event: $event.wrappedValue)
        
        presentationMode.wrappedValue.dismiss()
    }
}
