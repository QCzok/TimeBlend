// EventItemList.swift

import SwiftUI

struct EventItemList: View {
    @State private var events: [EventItem] = []
    @State private var selectedFilter: EventTypeFilter = .all

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
                    ForEach(filteredEvents, id: \.self) { event in
                        HStack {
                            VStack {
                                EventRow(item: event)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .listRowSeparator(.hidden)
                    }.onDelete(perform: deleteEvent) // Enable swipe-to-delete
                }
                .listStyle(PlainListStyle())
                .onAppear {
                    loadEventsFromUserDefaults()
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
}

struct EventItemList_Previews: PreviewProvider {
    static var previews: some View {
        EventItemList()
    }
}
