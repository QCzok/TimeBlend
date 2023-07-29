import SwiftUI

struct DescriptionSelectorView: View {
    
    @Binding var selectedDescription: String
    
    var body: some View {
        
        // Event Description
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "text.bubble.fill")
                    .foregroundColor(.blue)
                Text("Event Description")
                    .foregroundColor(.primary)
                    .font(.headline)
            }

            TextEditor(text: $selectedDescription)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(height: 80) // Adjust the height of the TextEditor
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.blue, lineWidth: 1) // Add a blue border around the TextEditor
                                )
        }
        .padding(.horizontal)
    }
}
