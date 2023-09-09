//
//  ContentView.swift
//  Travel App Clive
//
//  Created by null-reaper on 8/20/23.
//
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var eventStore: EventStore

    var body: some View {

        Base()
            .environmentObject(eventStore)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
