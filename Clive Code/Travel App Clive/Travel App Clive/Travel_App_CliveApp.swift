//
//  Travel_App_CliveApp.swift
//  Travel App Clive
//
//  Created by null-reaper on 8/20/23.
//

import SwiftUI

@main
struct Travel_App_CliveApp: App {
    @StateObject private var eventStore = EventStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(eventStore)
        }
    }
}
