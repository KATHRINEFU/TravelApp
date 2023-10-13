//
//  NotificationsView.swift
//  Travel App Clive
//
//  Created by null-reaper on 9/30/23.
//

import SwiftUI

struct NotificationsView: View {
    
    @State var notifications: [Message]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 25) {
                
                ForEach(notifications) { notification in
                    MessageView(message: notification)
                }
                
            }
        }
    }
}

#Preview {
    NotificationsView(notifications: [
        Message(user_name: "Yuehao (Kate) Fu", user_profile: "profile_yuehao", timestamp: "09/23/2023 15:30", text: "Okay!", image: ""),
        Message(user_name: "Clive Gomes", user_profile: "profile_clive", timestamp: "09/23/2023 15:25", text: "Let's meet up at the entrance!", image: "hotel_entrance")
    ])
}
