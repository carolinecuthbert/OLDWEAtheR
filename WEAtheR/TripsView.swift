//
//  TripsView.swift
//  ToDoList
//
//  Created by Scholar on 6/26/24.
//

import SwiftUI
import SwiftData

struct TripsView: View {
    @State private var showNewTask = false
    @Query var trips: [TripItem]
    @Environment(\.modelContext) var modelContext
    var body: some View {
        NavigationStack{
            VStack {
                HStack {
                    Text("Trips")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                    Spacer()
                    NavigationLink(destination: CreateView(tripItem: TripItem(title: "", location: "", date: "", occasion: ""))) {
                        Text("+")
                            .font(.system(size: 50))
                    }
                }//end of HStack
                .padding()
                Spacer()
                List {
                    ForEach(trips) { tripItem in
                        Text(tripItem.title)
                    }
                    .onDelete(perform: deleteToDo)
                }
                .listStyle(.plain)
            }//end of VStack
        }
    }//end of body
    func deleteToDo(at offsets: IndexSet) {
        for offset in offsets {
            let tripItem = trips[offset]
            modelContext.delete(tripItem)
        }
    }
}//end of view

#Preview {
    TripsView()
}
