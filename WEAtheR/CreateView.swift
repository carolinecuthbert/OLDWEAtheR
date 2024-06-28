import SwiftUI
import SwiftData

struct CreateView: View {
    @State private var isSaved = false
    @State private var didntComplete = false
    @Bindable var tripItem: TripItem
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Spacer()
                    if (didntComplete) {
                        Text("Please fill out all fields!")
                            .italic()
                            .font(.system(size: 25))
                            .fontWeight(.medium)
                            .foregroundStyle(Color.red)
                    }
                    Spacer()
                    HStack {
                        Text("Trip Title:")
                            .font(.system(size: 30))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } // HStack
                    
                    TextField("Type here...", text: $tripItem.title)
                        .font(.system(size: 25))
                        .multilineTextAlignment(.center)
                        .background(Color(.systemGroupedBackground))
                        .cornerRadius(15)
                        .padding(.bottom)
                        .lineLimit(5)
                    
                    Spacer()
                        .frame(height: 40)
                    
                    HStack {
                        Text("Location:")
                            .font(.system(size: 30))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } // HStack
                    
                    TextField("Type here...", text: $tripItem.location)
                        .font(.system(size: 25))
                        .multilineTextAlignment(.center)
                        .background(Color(.systemGroupedBackground))
                        .cornerRadius(15)
                        .padding(.bottom)
                    
                    Spacer()
                        .frame(height: 40)
                    
                    HStack {
                        Text("Dates")
                            .font(.system(size: 30))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } // HStack
                    
                    TextField("Type a number here...", text: $tripItem.date)
                        .font(.system(size: 25))
                        .multilineTextAlignment(.center)
                        .background(Color(.systemGroupedBackground))
                        .cornerRadius(15)
                        .padding(.bottom)
                }
                
                .padding()
                
                Spacer()
                    .frame(height: 50)
                
                VStack {
                    Text("Occasion:")
                        .font(.system(size: 30))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    
                    HStack{
                        if (tripItem.occasion == "formal") {
                            Button("Formal") {}
                                .font(.title2)
                                .buttonStyle(.borderedProminent)
                                .foregroundStyle(Color.black)
                                .tint(Color("for"))
                                .border(Color.black, width: 4)
                        } else {
                            Button("Formal") {
                                tripItem.occasion = "formal"
                            }
                            .font(.title2)
                            .buttonStyle(.borderedProminent)
                            .foregroundStyle(Color.black)
                            .tint(Color("for"))
                        }
                        Spacer()
                            .frame(width: 20.0)
                        if (tripItem.occasion == "athletic") {
                            Button("Athletic") {}
                                .font(.title2)
                                .buttonStyle(.borderedProminent)
                                .foregroundStyle(Color.black)
                                .tint(Color("ath"))
                                .border(Color.black, width: 4)
                        } else {
                            Button("Athletic") {
                                tripItem.occasion = "athletic"
                            }
                            .font(.title2)
                            .buttonStyle(.borderedProminent)
                            .foregroundStyle(Color.black)
                            .tint(Color("ath"))
                        }
                        Spacer()
                            .frame(width: 20.0)
                        if (tripItem.occasion == "casual") {
                            Button("Casual") {}
                                .font(.title2)
                                .buttonStyle(.borderedProminent)
                                .foregroundStyle(Color.black)
                                .tint(Color("cas"))
                                .border(Color.black, width: 4)
                        } else {
                            Button("Casual") {
                                tripItem.occasion = "casual"
                            }
                            .font(.title2)
                            .buttonStyle(.borderedProminent)
                            .foregroundStyle(Color.black)
                            .tint(Color("cas"))
                            
                        }
                    }//end of HStack
                    Spacer()
                        .frame(height: 125.0)
                    
                    if (isSaved) {
                        NavigationLink(destination: Text("Hello")) {
                            Text("Continue")
                        }
                        .font(.title2)
                        .buttonStyle(.borderedProminent)
                        .foregroundStyle(Color.black)
                        .tint(Color("cre"))
                    } else {
                        Button("Create List ✔") {
                            if (tripItem.title == "" || tripItem.location == "" || tripItem.date == "" || tripItem.occasion == "") {
                                didntComplete = true
                            } else {
                                didntComplete = false
                                addTrip()
                                isSaved = true
                            }
                        }
                        .font(.title2)
                        .buttonStyle(.borderedProminent)
                        .foregroundStyle(Color.black)
                        .tint(Color("cre"))
                    }
                }
            }
        }
    }
    func addTrip() {
        let trip = TripItem(title: tripItem.title, location: tripItem.location, date: tripItem.date, occasion: tripItem.occasion)
        modelContext.insert(trip)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: TripItem.self, configurations: config)

    let trip = TripItem(title: "", location: "", date: "", occasion: "")
    return CreateView(tripItem: trip)
        .modelContainer(container)
}
