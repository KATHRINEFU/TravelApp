//
//  PollsListView.swift
//  Travel App Clive
//
//  Created by null-reaper on 9/30/23.
//

import SwiftUI

struct PollsListView: View {
    
    @State var polls: [Poll]
    @Binding var showDetailView: Bool
    @Binding var selectedPoll: Poll?

    var animation: Namespace.ID

    var body: some View {
        ScrollView {
            
            if polls.count == 0 {
                VStack {
                    Text("No Polls")
                        .padding(.top, getRect().height / 4)
                }
            } else {
                VStack(spacing: 20) {
                    
                    ForEach(polls) { poll in
                        PollCardView(poll: poll, showDetailView: $showDetailView, selectedPoll: $selectedPoll, animation: animation)
                            .onTapGesture {
                                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                                    selectedPoll = poll
                                    showDetailView = true
                                }
                            }
                    }
                    
                }
            }
        }
    }
}

#Preview {
    PollsView()
}
