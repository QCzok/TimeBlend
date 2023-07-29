
import SwiftUI

struct LocationSelectorView: View {
    
    @Binding var location: String
    var body: some View {
        HStack {
            Image(systemName: "location.fill")
                .foregroundColor(.blue)
            TextField("Event Location", text: $location)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding(.horizontal)
    }
}
