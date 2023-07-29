import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String

    var body: some View {
            HStack {
                TextField("Search events", text: $searchText)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 32)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .overlay(
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.leading, 24)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading),
                        alignment: .leading
                    )
            }
        }
}
