//
//  AddEventView.swift
//  TravelApp
//
//  Created by KateFu on 8/25/23.
//

import SwiftUI

struct EventType: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let icon: String
}

struct EventMaxView: View {
    let eventTypes: [EventType] = [
            EventType(name: "Restaurant", icon: "🍔"),
            EventType(name: "Concert", icon: "🎵"),
            EventType(name: "Movie", icon: "🎬"),
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
    
    @Binding var isPresented: Bool
    
    @EnvironmentObject var eventStore: EventStore
    
    let buttonWidth: CGFloat = 100 // Adjust the width as needed
    
    var body: some View {
        ScrollView{
            VStack {
                Text("Add Event").font(.largeTitle)
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
                
                VStack{
                    TextField("Event Name", text: $name)
                        .padding()
                    
                    TextField("Location", text: $location)
                        .padding()
                    
                    DatePicker("Date", selection: $date, in: ...Date(), displayedComponents: .date)
                        .padding()
                    
                    DatePicker("Start Time", selection: $startTime, displayedComponents: .hourAndMinute)
                        .padding()
                    
                    DatePicker("End Time", selection: $endTime, displayedComponents: .hourAndMinute)
                        .padding()
                    
                    TextField("Cost", value: $cost, format: .currency(code: "USD"))
                        .padding()
                }
                
                
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 100)
                        .padding()
                } else {
                    Image("upload-cloud-icon") // Make sure to replace "upload-cloud-icon" with the actual image name in your assets
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 100)
                        .padding()
                }
                
                Button(action: {
                    isImagePickerPresented.toggle()
                }) {
                    Text("Upload Cover")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(selectedImage: $selectedImage)
                }
                .padding()
                
                Button(action: {
                    let event = Event(eventIcon: selectedEventType?.icon ?? "",
                        name:name,
                        location: location,
                        image: selectedImage,
                        startTime: startTime,
                        endTime: endTime
                    )
                    eventStore.addEvent(event: event)
                    isPresented = false
                }) {
                    Text("Save")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.pink)
                        .cornerRadius(10)
                }
                .padding()
                
//                EventView(
//                    eventIcon: selectedEventType?.icon ?? "",
//                    location: location,
//                    image: selectedImage)
            }
        }
    }
}
