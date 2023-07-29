
import SwiftUI

struct TypeSelectorView: View {
    
    @Binding var type: EventType
    
    var body: some View {
        HStack {
            Image(systemName: "tag.fill")
                .foregroundColor(.blue)
            Picker("Event Type", selection: $type) {
                Text("Work").tag(EventType.work)
                Text("Private").tag(EventType.privat)
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .padding(.horizontal)
    }
}
