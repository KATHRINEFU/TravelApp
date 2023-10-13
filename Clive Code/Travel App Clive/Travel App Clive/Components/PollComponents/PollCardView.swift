//
//  PollCardView.swift
//  Travel App Clive
//
//  Created by null-reaper on 9/30/23.
//

import SwiftUI
import Charts

struct PollCardView: View {
    
    @State var poll: Poll
    @Binding var showDetailView: Bool
    @Binding var selectedPoll: Poll?

    var animation: Namespace.ID
    
    var body: some View {
        
        GeometryReader {
            let size = $0.size
            
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 6) {
                    
                    Text(poll.question)
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text("By: \(poll.author)")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Text("\(poll.votes.reduce(0, +))")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.blue)
                        
                        Text((poll.votes.reduce(0, +)) == 1 ? "Vote" : "Votes")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        
                        Spacer(minLength: 0)

                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    
                }
                .padding(20)
                .frame(width: size.width/2, height: size.height*0.8)
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white)
                        .shadow(color: Color(.systemGray).opacity(0.3), radius: 8, x: 5, y: 5)
                        .shadow(color: Color(.systemGray).opacity(0.3), radius: 8, x: -5, y: -5)
                }
                .zIndex(1)

                ZStack {
                    
                    if !(showDetailView && selectedPoll?.id == poll.id) {
                        VStack(alignment: .leading, spacing: 6) {
                            
                            Chart {
                                ForEach(Array(poll.votes.enumerated()), id:\.element) { index, vote in
                                    SectorMark(angle: .value("Votes", vote), innerRadius: .ratio(0.5),  angularInset: 4)
                                        .cornerRadius(8)
                                        .foregroundStyle(by: .value("Option", poll.options[index]))
                                }
                            }
                            .chartLegend(position: .bottom, alignment: .center, spacing: 25)
                            .padding(20)
                            .matchedGeometryEffect(id: poll.id, in: animation)

                        }
                        .frame(width: size.width/2, height: size.height)
                        .background {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.white)
                                .matchedGeometryEffect(id: poll.id, in: animation)
                                .shadow(color: Color(.systemGray).opacity(0.3), radius: 8, x: 5, y: 5)
                                .shadow(color: Color(.systemGray).opacity(0.3), radius: 8, x: -5, y: -5)
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(width: size.width)
        }
        .frame(height: 220)
            
    }
    

}

#Preview {
    PollsView()
}
