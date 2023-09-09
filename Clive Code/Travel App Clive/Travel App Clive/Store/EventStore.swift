//
//  EventStore.swift
//  TravelApp
//
//  Created by KateFu on 8/26/23.
//

import Foundation
import UIKit

struct Event: Identifiable {
    let id = UUID()
    let eventIcon: String
    let name: String
    let location: String
    let image: UIImage?
    let startTime: Date
    let endTime: Date
}

class EventStore: ObservableObject {
    @Published var events: [Event] = []
    
    func addEvent(event: Event) {
        events.append(event)
    }
}
