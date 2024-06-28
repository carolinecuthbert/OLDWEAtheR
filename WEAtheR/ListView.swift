// LIST VERSION

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
