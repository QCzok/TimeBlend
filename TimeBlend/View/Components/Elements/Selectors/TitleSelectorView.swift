
import SwiftUI

struct TitleSelectorView: View {
    
    @Binding var title: String
    
    var body: some View {
        HStack {
            Image(systemName: "pencil.circle.fill")
                .foregroundColor(.blue)
            TextField("Event Title", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding(.horizontal)
    }
}
