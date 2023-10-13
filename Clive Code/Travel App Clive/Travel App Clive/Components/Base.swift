//
//  Base.swift
//  Travel App Clive
//
//  Created by null-reaper on 8/20/23.
//

import SwiftUI

struct Base: View {
    
    @State private var selectedTab = "Events"
    @State private var showNotifications: Bool = false
    @State var notifications: [Message] = [
        Message(user_name: "Yuehao (Kate) Fu", user_profile: "profile_yuehao", timestamp: "09/23/2023 15:30", text: "Okay!", image: ""),
        Message(user_name: "Clive Gomes", user_profile: "profile_clive", timestamp: "09/23/2023 15:25", text: "Let's meet up at the entrance!", image: "hotel_entrance")
    ]
    
    @EnvironmentObject var eventStore: EventStore

    var body: some View {
        
        ZStack {
            
            TabView(selection: $selectedTab) {
                
                EventsView()
                    .tag("Events")
                    .frame(height: getRect().height - 80)
                    .padding(.top, 180)
                    .offset(y: getRect().height*0.025)
                    .environmentObject(eventStore)

                
                MapView()
                    .tag("Map")
                    .frame(height: getRect().height - 80)
                    .padding(.top, 180)
                
                PollsView()
                    .tag("Polls")
                    .frame(height: getRect().height - 80)
                    .padding(.top, 180)


                
                Text("Feed")
                    .tag("Feed")
                
            }

            
            VStack {
                
                Spacer()
                BottomMenu(selectedTab: $selectedTab)
            }
            .frame(height: getRect().height)

            TopMenu(showNotifications: $showNotifications, notification: $notifications[0])
                        
        }
        .fullScreenCover(isPresented: $showNotifications, onDismiss: {
            withAnimation(.snappy) {
                showNotifications = false
            }
        }) {
            ZStack {
                Color(.systemGray6).opacity(0.5)
                
                VStack {
                 
                    Text("Notifications")
                        .font(.largeTitle)
                        .padding(.top, getSafeArea().top + 60)
                    
                    NotificationsView(notifications: notifications)
                    
                    Spacer()
                }
                
            }
            .ignoresSafeArea()
            .overlay(alignment: .top) {
                Button(action: {
                    showNotifications = false
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundStyle(.black)
                        .background(.white, in:.circle)
                })
                .padding(10)
            }
        }
        .padding(.vertical, 5)
        .padding(.horizontal)
        .ignoresSafeArea()
    }
}

struct Base_Previews: PreviewProvider {
    static var previews: some View {
        Base()
            .environmentObject(EventStore())
    }
}
