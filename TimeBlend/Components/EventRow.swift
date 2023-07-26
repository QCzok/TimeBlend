

import SwiftUI

struct EventRow: View {
    
    @State var item: EventItem
    
    public var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: item.date)
    }
    
    public var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    public func timeLeft(from date: Date) -> String {
        let currentTime = Date()
        let timeLeft = date.timeIntervalSince(currentTime)

        if timeLeft < 0 {
            return "Event has started"
        } else {
            let components = Calendar.current.dateComponents([.day, .hour, .minute], from: currentTime, to: date)
            let days = components.day ?? 0
            let hours = components.hour ?? 0
            let minutes = components.minute ?? 0

            if days > 0 {
                return "\(days) day\(days == 1 ? "" : "s") left"
            } else {
                if hours > 0 {
                    return "\(hours) hr \(minutes) min left"
                } else {
                    return "\(minutes) min left"
                }
            }
        }
    }
    
    var body: some View {
        NavigationLink(destination: EventDetailView(event: $item)) {
            HStack {
                VStack() {
                    Image(systemName: item.type == .work ? "briefcase" : "person.2")
                        .foregroundColor(item.type == .work ? .blue : .green) // Customize the color as needed
                    HStack(){
                        Text(timeLeft(from: item.date))
                    }
                    HStack(){
                        Spacer()
                        Text(item.title)
                            .multilineTextAlignment(.leading)
                            .fontWeight(.bold)
                            .font(.title)
                        Spacer()
                    }
                    .foregroundColor(.black)
                    HStack{
                        Text(formattedDate)
                    }
                }
                
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}
