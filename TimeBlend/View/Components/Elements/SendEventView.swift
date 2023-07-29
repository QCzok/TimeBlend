
import SwiftUI

struct SendEventView: View {
    
    var event: EventItem
    
    private func shareEvent() {
        let text = "Hey, I wanted to share this event with you:\n\(event.title)\n\(event.date)"
        let activityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
           UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                shareEvent()
            }) {
                VStack {
                    Image(systemName: "square.and.arrow.up.fill")
                        .foregroundColor(.blue) // Change the color to blue
                        .font(.title) // Increase the font size

                    Text("Send")
                        .foregroundColor(.blue) // Change the color to blue
                        .font(.headline) // Increase the font size
                }
                .padding(8) // Add some padding around the content
            }
        }
    }

}
