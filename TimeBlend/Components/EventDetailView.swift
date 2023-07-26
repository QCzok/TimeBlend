

import SwiftUI

struct EventDetailView: View {
    let event: EventItem

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
            
            HStack {
                Image(systemName: "tag")
                    .foregroundColor(.blue)
                
                Text(event.type.rawValue.capitalized)
                    .font(.subheadline)
            }
            
            HStack {
                Text(formatDuration(_: event.duration))
                    .font(.subheadline)
            }
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Event Detail", displayMode: .inline)
    }
    
    private func formatDuration(_ duration: Double) -> String {
        let totalMinutes = Int(duration * 60)
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        
        if hours > 0 && minutes > 0 {
            return "\(hours)h \(minutes)m"
        } else if hours > 0 {
            return "\(hours)h"
        } else {
            return "\(minutes)m"
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

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailView(event: EventItem(
            title: "Birthday Party",
            description: "Johnny is getting 30",
            date: Date(),
            duration: 3.0,
            type: .privat
        ))
    }
}
