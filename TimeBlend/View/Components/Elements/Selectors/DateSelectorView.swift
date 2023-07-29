
import SwiftUI

struct DateSelectorView: View {
    
    @Binding var date: Date
    
    var body: some View {
        HStack {
            Image(systemName: "calendar")
                .foregroundColor(.blue)
            DatePicker("Event Date", selection: $date, displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(DefaultDatePickerStyle())
        }
        .padding(.horizontal)
    }
}
