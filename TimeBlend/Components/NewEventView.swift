

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
                    // Event Title
                    HStack {
                        Image(systemName: "pencil.circle.fill")
                            .foregroundColor(.blue)
                        TextField("Event Title", text: $newEventTitle)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding(.horizontal)

                    // Event Description
                    DescriptionSelectorView(selectedDescription: $newEventDescription)

                    // Event Date and Time
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.blue)
                        DatePicker("Event Date", selection: $newEventDate, displayedComponents: [.date, .hourAndMinute])
                            .datePickerStyle(DefaultDatePickerStyle())
                    }
                    .padding(.horizontal)

                   
                    // Duration
                    DurationSelectorView(selectedHours: $newEventDurationHours, selectedMinutes: $newEventDurationMinutes)

                    .padding(.horizontal)

                    // Event Type
                    HStack {
                        Image(systemName: "tag.fill")
                            .foregroundColor(.blue)
                        Picker("Event Type", selection: $newEventType) {
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
                            TextField("Event Location", text: $newEventLocation)
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
        saveEventsToUserDefaults()
        presentationMode.wrappedValue.dismiss()
    }
    
    private func saveEventsToUserDefaults() {
        let data = try? JSONEncoder().encode(events)
        UserDefaults.standard.set(data, forKey: "savedEvents")
    }
}
