import SwiftUI

struct TimeBlendView: View {
    var body: some View {
        VStack {
            EventItemList()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TimeBlendView()
    }
}
