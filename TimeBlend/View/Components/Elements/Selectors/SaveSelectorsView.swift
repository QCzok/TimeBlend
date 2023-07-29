
import SwiftUI

struct SaveSelectorsView: View {
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "checkmark.circle.fill")
            Text("Save")
            Spacer()
        }
        .foregroundColor(.white)
        .padding()
        .background(Color.blue)
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

struct SaveSelectorsView_Previews: PreviewProvider {
    static var previews: some View {
        SaveSelectorsView()
    }
}
