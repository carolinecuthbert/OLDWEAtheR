import SwiftUI
import SwiftData

struct ListView: View {
    @Bindable var tripItem: TripItem
    @Environment(\.modelContext) var modelContext
    @State private var newItemName: String = ""
    @State private var newQuantity: String = "1"

    var body: some View {
        VStack {
            TextField("Add new item", text: $newItemName)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Quantity", text: $newQuantity)
                .keyboardType(.numberPad)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: addItem) {
                Text("Add Item")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            HStack {
                Text("Item")
                    .font(.headline)
                Spacer()
                Text("Quantity")
                    .font(.headline)
            }
            .padding(.leading, 20.0)
            .padding(.trailing, 1.0)
            .padding(.vertical)
            List {
                ForEach(tripItem.listItems) { listItem in
                    HStack {
                        Button(action: {
                            toggleChecked(listItem: listItem)
                        }) {
                            if (listItem.isChecked) {
                                Image(systemName: "checkmark.square")
                                    .foregroundStyle(Color("grey"))
                            } else {
                                Image(systemName: "square")
                            }
                        }
                        if (listItem.isChecked) {
                            Text(listItem.name)
                                .strikethrough()
                                .foregroundStyle(Color("grey"))
                        } else {
                            Text(listItem.name)
                        }
                        Spacer()
                        Rectangle()
                            .fill(Color("light grey"))
                            .frame(width: 1)
                        Spacer()
                            .frame(width: 20.0)
                        if (listItem.isChecked) {
                            Text("\(listItem.quantity)")
                                .strikethrough()
                                .foregroundStyle(Color("grey"))
                        } else {
                            Text("\(listItem.quantity)")
                        }
                    }
                    .padding(.vertical, 8)
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(PlainListStyle())
        }
        .navigationTitle(tripItem.title)
        .padding()
    }

    func addItem() {
        guard let quantity = Int(newQuantity) else { return }
        let newListItem = ListItem(name: newItemName, quantity: quantity, isChecked: false)
        tripItem.listItems.append(newListItem)
        modelContext.insert(newListItem)
        newItemName = ""
        newQuantity = "1"
    }

    func toggleChecked(listItem: ListItem) {
        listItem.isChecked.toggle()
    }

    func deleteItems(at offsets: IndexSet) {
        for offset in offsets {
            let listItem = tripItem.listItems[offset]
            tripItem.listItems.remove(at: offset)
            modelContext.delete(listItem)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: TripItem.self, ListItem.self, configurations: config)
    let sampleTripItem = TripItem(title: "Sample Trip", location: "Sample Location", date: "2024-07-01", occasion: "Casual", listItems: [ListItem(name: "", quantity: 0, isChecked: false)])
    let sampleListItem1 = ListItem(name: "Coat", quantity: 5, isChecked: false)
    let sampleListItem2 = ListItem(name: "T-shirt", quantity: 3, isChecked: false)
    sampleTripItem.listItems.append(contentsOf: [sampleListItem1, sampleListItem2])
    return ListView(tripItem: sampleTripItem)
        .modelContainer(container)
}

    
/*// LIST VERSION

import SwiftUI
struct Items: Identifiable {
    let id = UUID()
    let check: Bool
    let item: String
    let unit: Int
}

struct ListView: View {
    @State private var items = [
        Items(check: true, item: "Boots", unit: 1),
        Items(check: true, item: "Sneakers", unit: 2),
        Items(check: false, item: "Sandals", unit: 1),
        Items(check: true, item: "Socks", unit: 4)
    ]
    
    @State var selectedTab = 2

    var body: some View {
        VStack {
//            HStack {
//                Text("<- Trips")
//                    .padding()
//                    //.frame(width: 200)
//                Spacer()
//
//                    Button(action: {
//                        print("Make a new list?")
//                    }) {
//                        Spacer()
//                        Image(systemName: "plus")
//                            .resizable()
//                            .frame(width: 20, height: 20)
//                            .padding()
//                        //.frame(width: 200)
//                    }
//            }
            
            HStack {
                TextField("New List", text: .constant(""))
                    .font(.system(size: 30))
                    .fontWeight(.black)
                    .padding()

                TextField("                   < 7 days >", text: .constant(""))
                    .fontWeight(.bold)
                    .padding()
            }
            
                Text("Item                                                            Unit")
                .font(.system(size: 19))
                .font(.title3)
                .fontWeight(.medium)

            List(items) { item in
                HStack {
                    //Text(item.check ? "✓" : "X")
                    Image(systemName: "square")
                    Text(item.item)
                    Spacer()
                    Text("\(item.unit)")
                }
            }
            .listStyle(PlainListStyle())
            //.padding()
            
            TabView(selection: $selectedTab) {
                Image(systemName: "")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                    .tabItem {
                        Image(systemName: "house")
                        //Text("home")
                    }
                    .tag(0) // idk what this does
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
*/
