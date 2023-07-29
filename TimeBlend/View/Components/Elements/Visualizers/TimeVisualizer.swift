import SwiftUI



struct TimeVisualizer: View {
    
    var time: Date
    
    private var formattedTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: time)
    }

    var body: some View {
        Text(formattedTime)
            .font(.subheadline)
    }
}
