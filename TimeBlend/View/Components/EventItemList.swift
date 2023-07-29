import SwiftUI

struct EventItemList: View {
    @State private var events: [EventItem] = []
    @State var selectedFilter: EventTypeFilter = .all
    @State private var isRefreshing: Bool = false
    @State var searchText: String = ""

    var filteredEvents: [EventItem] {
        var filteredEvents = events

        if !searchText.isEmpty {
            filteredEvents = filteredEvents.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }

        switch selectedFilter {
        case .all:
            return filteredEvents
        case .privateEvent:
            return filteredEvents.filter { $0.type == .privat }
        case .work:
            return filteredEvents.filter { $0.type == .work }
        }
    }
    
    private func deleteEvent(at offsets: IndexSet) {
        events.remove(atOffsets: offsets)
        EventDataManager().saveEventItems(events)
    }
    
    private func moveEvent(from source: IndexSet, to destination: Int) {
        events.move(fromOffsets: source, toOffset: destination)
        EventDataManager().saveEventItems(events)
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
                
                SearchBarView(searchText: $searchText).padding(.top)
                
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
                                    EventDataManager().saveEventItems(events)
                                }
                                .cornerRadius(4)
                                .shadow(radius: 2)
                                .padding(.trailing, 8)
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
                    events = EventDataManager().loadEventItems()
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
