

import SwiftUI
import MessageUI

struct EventDetailView: View {
    
    @Binding var event: EventItem
    
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

            TimeVisualizer(time: event.date)
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
            Image(systemName: "clock.fill")
                .foregroundColor(.blue)

            Text("\(event.hours)h \(event.minutes)m")
                .font(.subheadline)
        }
    }
    
    private var editButton: some View {
        NavigationLink(destination: EditEventView(event: $event)) {
            Text("Edit")
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
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
}

