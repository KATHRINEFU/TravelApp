//
//  AddEventView.swift
//  TravelApp
//
//  Created by KateFu on 8/25/23.
//

import SwiftUI
import MapKit

struct EventType: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let icon: String
}

struct EventMaxView: View {
    let eventTypes: [EventType] = [
            EventType(name: "Transport", icon: "✈️"),
            EventType(name: "Restaurant", icon: "🍔"),
            EventType(name: "Concert", icon: "🎵"),
            EventType(name: "Movie", icon: "🎬"),
            EventType(name: "Place", icon: "🏞️"),
            EventType(name: "Sport", icon: "🎾"),
            EventType(name: "Nature", icon: "🏔️"),
    ]
    @State private var selectedEventType: EventType?
    @State private var name: String = ""
    @State private var location: String = ""
    @State private var date: Date = Date()
    @State private var startTime: Date = Date()
    @State private var endTime: Date = Date()
    @State private var cost: Double = 0.0
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    
    @State private var selectedLocation: MKLocalSearchCompletion?
    @State private var searchResults: [MKLocalSearchCompletion] = []
    
    @EnvironmentObject var eventStore: EventStore
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var locationService: LocationService
    
    @State private var isEditingEvent = false
    
    init() {
            _selectedEventType = State(initialValue: eventTypes.first)
        locationService = LocationService()
        }
    
    let buttonWidth: CGFloat = 100 // Adjust the width as needed
    
    var body: some View {
        ScrollView{
            VStack(spacing: 0){
                ZStack(alignment: .topLeading) {
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 180)
                            .clipped()
                    } else {
                        Image("upload-cloud-icon") // Default image name
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 180)
                    }
                    
                    VStack{
                        HStack {
                            Button(action: {
                                dismiss()
                            }) {
                                Text("Cancel")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                    .padding(.leading, 20)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            
                            Text(name.isEmpty ? "Untitled Event" : name)
                                .font(.title2)
                                .padding(.top, 10)
                                .background(selectedImage != nil ? Color.white.opacity(0.5) : Color.clear)
                            
                            
                            Button(action: {
                                let event = Event(eventIcon: selectedEventType?.icon ?? "",
                                                  name: name,
                                                  location: location,
                                                  image: selectedImage,
                                                  startTime: startTime,
                                                  endTime: endTime
                                )
                                eventStore.addEvent(event: event)
                                print(eventStore.events)
                                dismiss()
                            }) {
                                Text("Save")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                    .padding(.trailing, 20)
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(eventTypes, id: \.self) { eventType in
                                    Button(action: {
                                        selectedEventType = eventType
                                    }) {
                                        VStack {
                                            Text(eventType.icon)
                                                .font(.largeTitle)
                                            Text(eventType.name)
                                                .fontWeight(.semibold)
                                        }
                                    }
                                    .frame(width: buttonWidth)
                                    .padding()
                                    .background(selectedEventType == eventType ? Color.blue : Color.pink)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                }
                            }
                        }
                    }
                }
                
                
                VStack{
                    TextField("Event Name", text: $name)
                        .padding()
                    
                    TextField("Search Location", text: $location)
                        .padding()
                    
//                    if locationService.status == .isSearching {
//                        ProgressView("Searching...")
//                            .padding()
//                    }
                    //                        else if locationService.status == .result {
                    //                            searchResults = locationService.searchResults
                    //                        }
//                    
//                    if !searchResults.isEmpty {
//                        List(searchResults, id: \.title) { result in
//                            Button(action: {
//                                selectedLocation = result
//                            }) {
//                                Text("\(result.title), \(result.subtitle)")
//                            }
//                        }
//                    }
                    
                    DatePicker("Date", selection: $date, in: ...Date(), displayedComponents: .date)
                        .padding()
                    
                    HStack {
                        DatePicker("From", selection: $startTime, displayedComponents: .hourAndMinute)
                        DatePicker("To", selection: $endTime, displayedComponents: .hourAndMinute)
                    }
                    .padding()
                    
                }.onReceive(locationService.$searchResults) { newSearchResults in
                    searchResults = newSearchResults
                    
                    print(searchResults)
                }
                
                Button(action: {
                    isImagePickerPresented.toggle()
                }) {
                    HStack {
                        Image(systemName: "photo.on.rectangle")
                        Text("Upload Cover")
                    }
                    .font(.headline)
                    .padding()
                    .foregroundColor(.blue)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 2)
                    )
                }
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(selectedImage: $selectedImage)
                }
                .padding(20)
                
//                HStack {
//                        Button(action: {
//                            dismiss()
//                        }) {
//                            Text("Cancel")
//                                .padding()
//                                .foregroundColor(.white)
//                                .background(Color.gray) // You can use any desired color
//                                .cornerRadius(10)
//                                .font(.headline)
//                        }
//                        .frame(width: 150)
//                        
//                        Spacer() // Add spacing between the buttons
//                        
//                        Button(action: {
//                            let event = Event(eventIcon: selectedEventType?.icon ?? "",
//                                              name: name,
//                                              location: location,
//                                              image: selectedImage,
//                                              startTime: startTime,
//                                              endTime: endTime
//                            )
//                            eventStore.addEvent(event: event)
//                            dismiss()
//                        }) {
//                            Text("Save")
//                                .padding()
//                                .foregroundColor(.white)
//                                .background(Color.pink)
//                                .cornerRadius(10)
//                                .font(.headline)
//                        }
//                        .frame(width: 150)
//                    }
            }
        }
    }
    
}

#Preview {
    EventMaxView()
}
