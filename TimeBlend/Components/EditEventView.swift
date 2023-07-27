
import SwiftUI

struct EditEventView: View {
    @Environment(\.presentationMode) var presentationMode
        @Binding var event: EventItem // Changed to a Binding
        
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
                    // Event Title
                    HStack {
                        Image(systemName: "pencil.circle.fill")
                            .foregroundColor(.blue)
                        TextField("Event Title", text: $editedTitle)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding(.horizontal)

                    // Event Description
                    DescriptionSelectorView(selectedDescription: $editedDescription)

                    // Event Date and Time
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.blue)
                        DatePicker("Event Date", selection: $editedDate, displayedComponents: [.date, .hourAndMinute])
                            .datePickerStyle(DefaultDatePickerStyle())
                    }
                    .padding(.horizontal)

                    // Duration
                    DurationSelectorView(selectedHours: $editedHours, selectedMinutes: $editedMinutes)

                    .padding(.horizontal)

                    // Event Type
                    HStack {
                        Image(systemName: "tag.fill")
                            .foregroundColor(.blue)
                        Picker("Event Type", selection: $editedType) {
                            Text("Work").tag(EventType.work)
                            Text("Private").tag(EventType.privat)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    .padding(.horizontal)
                    
                    // Event Location
                        HStack {
                            Image(systemName: "location.fill")
                                .foregroundColor(.blue)
                            TextField("Event Location", text: $editedLocation)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        .padding(.horizontal)

                    // Save Button
                    Button(action: saveEvent) {
                        HStack {
                            Spacer()
                            Image(systemName: "checkmark.circle.fill")
                            Text("Save")
                            Spacer()
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
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
        
        saveEventsToUserDefaults()
        
        presentationMode.wrappedValue.dismiss()
    }
    
    private func saveEventsToUserDefaults() {
        // Get the current saved events from UserDefaults (if any)
        if let data = UserDefaults.standard.data(forKey: "savedEvents") {
            do {
                // Decode the data into an array of EventItem objects
                var events = try JSONDecoder().decode([EventItem].self, from: data)
                
                // Find the index of the edited event in the array
                if let index = events.firstIndex(where: { $0.id == $event.wrappedValue.id }) {
                    // Update the event in the array with the edited event
                    events[index] = $event.wrappedValue
                    
                    // Encode the updated array of events and save it to UserDefaults
                    let updatedData = try JSONEncoder().encode(events)
                    UserDefaults.standard.set(updatedData, forKey: "savedEvents")
                }
            } catch {
                print("Error decoding or encoding events:", error)
            }
        }
    }
}
