import SwiftUI

struct LocationVisualizer: View {
    
    var event: EventItem
    
    var body: some View {
        HStack {
            Image(systemName: "location.fill")
                .foregroundColor(.blue)
            
            Text(event.location)
                .font(.subheadline)
        }
    }
}
