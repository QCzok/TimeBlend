

import SwiftUI

struct EventDetailView: View {
    
    @Binding var event: EventItem // Changed to a Binding
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(event.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(event.description)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
            
            Divider()
            
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(.blue)
                
                Text(formattedDate)
                    .font(.subheadline)
            }
            
            HStack {
                Image(systemName: "clock")
                    .foregroundColor(.blue)
                
                Text(formattedTime)
                    .font(.subheadline)
            }
            
            Divider()
            
            HStack {
                Image(systemName: "tag")
                    .foregroundColor(.blue)
                
                Text(event.type.rawValue.capitalized)
                    .font(.subheadline)
            }
            
            HStack {
                // Icon for duration
                Image(systemName: "clock.fill")
                    .foregroundColor(.blue)
                
                Text(String(event.hours) + "h " + String(event.minutes) + "m")
                    .font(.subheadline)
            }
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Event Detail", displayMode: .inline)
        .navigationBarItems(trailing: editButton) // Add the "Edit" button
    }
    
    private var editButton: some View {
        NavigationLink(destination: EditEventView(event: $event)) { // Pass a binding to the editedEvent
            Text("Edit")
        }
    }

    
    private var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: event.date)
    }
    
    private var formattedTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: event.date)
    }
}

