

import SwiftUI

struct EventRow: View {
    
    @State var item: EventItem
    @State var timeLeftText = ""
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var isDetailViewActive = false // State variable to control the navigation
    
    var body: some View {
        // Wrap the HStack with a NavigationLink
         NavigationLink(destination: EventDetailView(event: $item), isActive: $isDetailViewActive) {
             EmptyView()
         }
         .hidden() // Hide the navigation link, we'll trigger it manually
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
                                timeLeftText = TimeCalculator().timeLeft(from: item.date)
                            }
                            .onReceive(timer) { _ in
                                // Update the time left every second
                                timeLeftText = TimeCalculator().timeLeft(from: item.date)
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
            .onTapGesture {

                            isDetailViewActive = true // Set the state variable to true to trigger the navigation
                        }
                    
        }
    }

extension Color {
    static let snowWhite = Color(red: 0.99, green: 0.99, blue: 0.99)
}
