//
//  BottomMenu.swift
//  Travel App Clive
//
//  Created by null-reaper on 8/20/23.
//

import SwiftUI

struct BottomMenu: View {

    @Binding var selectedTab: String
    
    var body: some View {
        
        VStack {
                       
            Spacer()
            
            HStack(spacing: 0) {
                
                TabButton(title: "Events", image: "clock", selected: $selectedTab)
                
                Spacer(minLength: 0)

                TabButton(title: "Map", image: "map", selected: $selectedTab)

                Spacer(minLength: 0)
                
                TabButton(title: "Poll", image: "align.horizontal.left", selected: $selectedTab)

                Spacer(minLength: 0)
                
                TabButton(title: "Feed", image: "globe", selected: $selectedTab)

            }
            .padding(.vertical, 12)
            .padding(.horizontal)
            .background(Color(.systemGray6))

        }
        
    }
        
}

struct BottomMenu_Previews: PreviewProvider {
        
    static var previews: some View {
        Base()
            .environmentObject(EventStore())
    }
}
