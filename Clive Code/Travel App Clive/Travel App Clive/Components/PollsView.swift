//
//  PollsView.swift
//  Travel App Clive
//
//  Created by null-reaper on 9/30/23.
//

import SwiftUI

struct PollsView: View {
    
    @State private var index: Int = 1
    @State private var offset: CGFloat = 0
    var width = UIScreen.main.bounds.width
    
    @State private var open_polls: [Poll] = [
        Poll(trip: "Summer Vacation", question: "Do you guys prefer chocolate or vanilla ice cream?", author: "Clive Gomes", options: [
            "chocolate",
            "vanilla"
        ], votes: [1, 0], chat: [
            Message(user_name: "Clive Gomes", user_profile: "profile_clive", timestamp: "09/22/2023 10:04", text: "Yummy!", image: "chocolate_ice_cream"),
            Message(user_name: "Yuehao (Kate) Fu", user_profile: "profile_yuehao", timestamp: "09/22/2023 12:11", text: "Looks delicious!", image: "")
        ]),
        Poll(trip: "Summer Vacation", question: "When should we have lunch?", author: "Yuehao (Kate) Fu", options: [
            "11:00 am",
            "12:00 pm",
            "01:00 pm"
        ], votes: [0, 2, 4], chat: [])
    ]
    
    @State private var closed_polls: [Poll] = []
    
    @State private var my_polls: [Poll] = []
    
    @Namespace private var animation
    @State private var showDetailView: Bool = false
    @State private var selectedPoll: Poll?

    var body: some View {
        VStack(spacing: 0) {
            
            PollTabs(index: self.$index, offset: self.$offset)
            
            GeometryReader { g in
            
                HStack(spacing: 0) {
                    
                    PollsListView(polls: open_polls, showDetailView: $showDetailView, selectedPoll: $selectedPoll, animation: animation)
                    .padding(.top)
                    .frame(width: g.frame(in: .global).width)
                    
                    PollsListView(polls: closed_polls, showDetailView: $showDetailView, selectedPoll: $selectedPoll, animation: animation)
                    .padding(.top)
                    .frame(width: g.frame(in: .global).width)

                    PollsListView(polls: my_polls, showDetailView: $showDetailView, selectedPoll: $selectedPoll, animation: animation)
                    .padding(.top)
                    .frame(width: g.frame(in: .global).width)

                }
                .offset(x: self.offset)
                .highPriorityGesture(DragGesture()
                    .onEnded({ (value) in
                        
                        if value.translation.width > 50 {
                            self.switchView(left: false)
                        }
                        if -value.translation.width > 50 {
                            self.switchView(left: true)
                        }
                        
                    })
                )
            }
            
            Spacer()
        }
        .overlay {
            if let selectedPoll, showDetailView {
                PollDetailView(poll: selectedPoll, show: $showDetailView, animation: animation)
                    .transition(.asymmetric(insertion: .identity, removal: .offset(y: 5)))
            }
        }
    }
    
    func switchView(left: Bool) {
        
        if left {
            
            if self.index != 3 {
                self.index += 1
            }
            
        } else {
            
            if self.index != 1 {
                self.index -= 1
            }
            
        }
        
        if self.index == 1 {
            self.offset = 0
        } else if self.index == 2 {
            self.offset = -self.width
        } else {
            self.offset = -2*self.width
        }
        
    }}

struct PollTabs: View {

    @Binding var index: Int
    @Binding var offset: CGFloat
    var width = UIScreen.main.bounds.width
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text("Polls")
                .font(.title)
                .foregroundStyle(.black)
                .padding(.leading)
                .padding(.bottom)
                .padding(.top)
            
            HStack {
                
                Button(action: {
                    
                    self.index = 1
                    self.offset = 0
                    
                }, label: {
                    
                    VStack(spacing: 8) {
                        HStack(spacing: 12) {
                            
                            Image(systemName: "lock.open.fill")
                                .foregroundStyle(self.index == 1 ? .black : Color.black.opacity(0.7))
                            
                            Text("Open")
                                .foregroundStyle(self.index == 1 ? .black : Color.black.opacity(0.7))
                        }
                        
                        Capsule()
                            .fill(self.index == 1 ? Color.black : Color.clear)
                            .frame(height: 4)
                    }
                    
                })
                
                Button(action: {
                    
                    self.index = 2
                    self.offset = -self.width

                }, label: {
                    
                    VStack(spacing: 8) {
                        HStack(spacing: 12) {
                            
                            Image(systemName: "lock.fill")
                                .foregroundStyle(self.index == 2 ? .black : Color.black.opacity(0.7))
                            
                            Text("Closed")
                                .foregroundStyle(self.index == 2 ? .black : Color.black.opacity(0.7))
                        }
                        
                        Capsule()
                            .fill(self.index == 2 ? Color.black : Color.clear)
                            .frame(height: 4)
                    }
                    
                })
                
                Button(action: {
                    
                    self.index = 3
                    self.offset = -2*self.width

                }, label: {
                    
                    VStack(spacing: 8) {
                        HStack(spacing: 12) {
                            
                            Image(systemName: "person.fill")
                                .foregroundStyle(self.index == 3 ? .black : Color.black.opacity(0.7))
                            
                            Text("My Polls")
                                .foregroundStyle(self.index == 3 ? .black : Color.black.opacity(0.7))
                        }
                        
                        Capsule()
                            .fill(self.index == 3 ? Color.black : Color.clear)
                            .frame(height: 4)
                    }
                    
                })

            }
        }
        .padding(.horizontal)
        .padding(.bottom, 8)
        .background(Color(.systemGray6))
    }
}

#Preview {
    PollsView()
}
