

import SwiftUI

struct NewEventView: View {
    @Binding var events: [EventItem]
    @Environment(\.presentationMode) var presentationMode

    
    @State private var newEventTitle = ""
    @State private var newEventDescription = ""
    @State private var newEventDate = Date()
    @State private var newEventDurationHours = 0
    @State private var newEventDurationMinutes = 0
    @State private var newEventType: EventType = .work
    
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
                    HStack {
                        Image(systemName: "text.bubble.fill")
                            .foregroundColor(.blue)
                        TextField("Event Description", text: $newEventDescription)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding(.horizontal)

                    // Event Date and Time
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.blue)
                        DatePicker("Event Date and Time", selection: $newEventDate, displayedComponents: [.date, .hourAndMinute])
                            .datePickerStyle(DefaultDatePickerStyle())
                    }
                    .padding(.horizontal)

                    // Event Duration
                    HStack {
                        Image(systemName: "clock.fill")
                            .foregroundColor(.blue)
                        Text("Event Duration:")
                            .foregroundColor(.primary)

                        VStack {
                            Text("\(newEventDurationHours)h")
                                Stepper(value: $newEventDurationHours, in: 0...24) {
                                }
                        }
                
                        VStack{
                            Text("\(newEventDurationMinutes)m")
                            Stepper(value: $newEventDurationMinutes, in: 0...59) {
                            }
                        }
                    }

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
            duration: Double(newEventDurationHours * 60 + newEventDurationMinutes) / 60.0,
            type: newEventType
        )

        events.append(newEvent)
        saveEventsToUserDefaults()
        presentationMode.wrappedValue.dismiss()
    }
    
    private func saveEventsToUserDefaults() {
        let data = try? JSONEncoder().encode(events)
        UserDefaults.standard.set(data, forKey: "savedEvents")
    }
    
    struct NewEventView_Previews: PreviewProvider {
        static var previews: some View {
            NewEventView(events: .constant([EventItem(
                id: UUID(),
                title: "Title",
                description: "Description in one or many sentences",
                date: Date.now,
                duration: 1.5,
                type: .privat
            )]))
        }
    }
}
