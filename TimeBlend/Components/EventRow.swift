

import SwiftUI

struct EventRow: View {
    
    @State var item: EventItem
    @State private var timeLeftText = ""
    @State private var weatherIcon: Image? // Store the weather icon as a state variable
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
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
            HStack(spacing: 16) {
                Image(systemName: item.type == .work ? "briefcase" : "person.2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .foregroundColor(item.type == .work ? .blue : .green)
                    .cornerRadius(8)
                    .padding(8)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(timeLeftText)
                            .font(.subheadline)
                            .onAppear {
                                // Recalculate the time left when the view appears for the first time
                                timeLeftText = timeLeft(from: item.date)
                            }
                            .onReceive(timer) { _ in
                                // Update the time left every second
                                timeLeftText = timeLeft(from: item.date)
                            }
                        Spacer()
                    }
                    
                    Text(item.title)
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                    
                    DateVisualizer(date: item.date)
                }
            }
            .padding()
            .background(Color.snowWhite)
            .cornerRadius(10)
            .shadow(radius: 4)
        }
    }
}

extension Color {
    static let snowWhite = Color(red: 0.99, green: 0.99, blue: 0.99)
}
