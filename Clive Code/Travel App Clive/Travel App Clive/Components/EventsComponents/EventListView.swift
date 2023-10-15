//
//  EventView.swift
//  TravelApp
//
//  Created by KateFu on 8/26/23.
//

import SwiftUI

struct EventListView: View {
    var event: Event
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                VStack {
                    Text(event.eventIcon)
                        .font(.largeTitle)
                    Text(event.location)
                        .fontWeight(.semibold)
                }
                Spacer()
                
                if let image = event.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: calculateEventHeight(startTime: event.startTime, endTime: event.endTime))
                        .cornerRadius(10)
                } else {
                    Image("upload-cloud-icon") // Default image name
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: calculateEventHeight(startTime: event.startTime, endTime: event.endTime))
                        .cornerRadius(10)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 3)
            .frame(height: calculateEventHeight(startTime: event.startTime, endTime: event.endTime))
        }
    }
    
    
    func calculateEventHeight(startTime: Date, endTime: Date) -> CGFloat {
        let calendar = Calendar.current
        let minutesInAnHour: Double = 60
        let minutes = Double(calendar.dateComponents([.minute], from: startTime, to: endTime).minute ?? 0)
        return CGFloat(minutes / minutesInAnHour * 40)
    }
}


let mockEvent: Event = {
    var calendar = Calendar.current
    var dateComponents = DateComponents()
    dateComponents.hour = 15 // 3 PM
    dateComponents.minute = 0
    let startTime = calendar.date(from: dateComponents)!
    
    dateComponents.hour = 18 // 5 PM
    let endTime = calendar.date(from: dateComponents)!
    
    return Event(eventIcon: "🍔", name: "Test Event", location: "Test Event", image: nil, startTime: startTime, endTime: endTime)
}()

#Preview{
    EventListView(event: mockEvent)
}
