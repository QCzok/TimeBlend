import SwiftUI

struct EventItemList: View {
    @State private var events: [EventItem] = []
    @State private var selectedFilter: EventTypeFilter = .all
    @State private var isRefreshing: Bool = false // Track the refreshing state

    var filteredEvents: [EventItem] {
        switch selectedFilter {
        case .all:
            return events
        case .privateEvent:
            return events.filter { $0.type == .privat }
        case .work:
            return events.filter { $0.type == .work }
        }
    }
    
    private func saveEventsToUserDefaults() {
        let data = try? JSONEncoder().encode(events)
        UserDefaults.standard.set(data, forKey: "savedEvents")
    }

    private func loadEventsFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: "savedEvents"),
           let savedEvents = try? JSONDecoder().decode([EventItem].self, from: data) {
            events = savedEvents
        }
    }

    private func deleteEvent(at offsets: IndexSet) {
        events.remove(atOffsets: offsets)
        saveEventsToUserDefaults()
    }
    
    private func moveEvent(from source: IndexSet, to destination: Int) {
        events.move(fromOffsets: source, toOffset: destination)
        saveEventsToUserDefaults()
    }

    var body: some View {
        NavigationView {
            VStack {
                Picker("Filter", selection: $selectedFilter) {
                    Text("All").tag(EventTypeFilter.all)
                    Text("Private").tag(EventTypeFilter.privateEvent)
                    Text("Work").tag(EventTypeFilter.work)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                List {
                    ForEach(filteredEvents, id: \.id) { event in
                        HStack {
                            Image(systemName: event.isMarked ? "star.fill" : "star")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15)
                                .foregroundColor(event.isMarked ? .yellow : .gray)
                                .onTapGesture {
                                    events[index(for: event)].isMarked.toggle()
                                    saveEventsToUserDefaults()
                                }
                                .cornerRadius(4)
                                .shadow(radius: 2)
                            
                            VStack {
                                EventRow(item: event)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .listRowSeparator(.hidden)
                    }
                    .onDelete(perform: deleteEvent) // Enable swipe-to-delete
                    .onMove(perform: moveEvent) // Enable drag-and-drop reordering
                }
                .listStyle(PlainListStyle())
                .onAppear {
                    loadEventsFromUserDefaults()
                }
                .refreshable {
                    loadEventsFromUserDefaults()
                    
                    // Finish the refreshing state
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        isRefreshing = false
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: NewEventView(events: $events)) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    enum EventTypeFilter: String, CaseIterable {
        case all
        case privateEvent = "Private"
        case work
    }
    
    private func index(for event: EventItem) -> Int {
        events.firstIndex { $0.id == event.id } ?? 0
    }
}

struct EventItemList_Previews: PreviewProvider {
    static var previews: some View {
        EventItemList()
    }
}

