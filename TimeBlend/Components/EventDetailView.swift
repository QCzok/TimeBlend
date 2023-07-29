

import SwiftUI
import MessageUI

struct EventDetailView: View {
    
    @Binding var event: EventItem // Changed to a Binding
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(event.title)
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(event.description)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)

            Divider()
        }
    }

    private var dateSection: some View {
        HStack {
            Image(systemName: "calendar")
                .foregroundColor(.blue)

            DateVisualizer(date: event.date)
        }
    }

    private var timeSection: some View {
        HStack {
            Image(systemName: "clock")
                .foregroundColor(.blue)

            Text(formattedTime)
                .font(.subheadline)
        }
    }

    private var typeSection: some View {
        HStack {
            Image(systemName: "tag")
                .foregroundColor(.blue)

            Text(event.type.rawValue.capitalized)
                .font(.subheadline)
        }
    }

    private var durationSection: some View {
        HStack {
            // Icon for duration
            Image(systemName: "clock.fill")
                .foregroundColor(.blue)

            Text("\(event.hours)h \(event.minutes)m")
                .font(.subheadline)
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Use the computed properties in the main body
            titleSection
            dateSection
            timeSection

            Divider()

            typeSection
            durationSection

            LocationVisualizer(event: event)

            Spacer()
            
            SendEventView(event: event)
        }
        .padding()
        .navigationBarTitle("Event Detail", displayMode: .inline)
        .navigationBarItems(trailing: editButton)
    }
    
    private var editButton: some View {
        NavigationLink(destination: EditEventView(event: $event)) { // Pass a binding to the editedEvent
            Text("Edit")
        }
    }
    
    private var formattedTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: event.date)
    }
}

