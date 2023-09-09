//
//  Base.swift
//  Travel App Clive
//
//  Created by null-reaper on 8/20/23.
//

import SwiftUI

struct Base: View {
    
    @State var selectedTab = "Events"
    
    @EnvironmentObject var eventStore: EventStore

    var body: some View {
        
        ZStack {
            
            TabView(selection: $selectedTab) {
                
                EventsView()
                    .tag("Events")
                    .frame(width: getRect().width, height: getRect().height*0.75)
                    .offset(y: getRect().height*0.025)
                    .environmentObject(eventStore)

                Text("Map")
                    .tag("Map")
                
                Text("Poll")
                    .tag("Poll")
                
                Text("Feed")
                    .tag("Feed")
                
            }

            
            BottomMenu(selectedTab: $selectedTab)
            
            TopMenu()
                        
        }
    }
}

struct Base_Previews: PreviewProvider {
    static var previews: some View {
        Base()
    }
}
