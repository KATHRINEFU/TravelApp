//
//  PollDetailView.swift
//  Travel App Clive
//
//  Created by null-reaper on 9/30/23.
//

import SwiftUI
import Charts

struct PollDetailView: View {
    
    @State var poll: Poll
    @Binding var show: Bool
    var animation: Namespace.ID
    
    @State private var option_selected: Bool = false
    @State private var selected_option: String = ""

    var body: some View {
        VStack(spacing: 15) {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.35)) {
                    show = false
                }
            }, label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .contentShape(Rectangle())
            })
            .padding([.leading, .vertical], 15)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            GeometryReader {
                let size = $0.size
                
                HStack(spacing: 20) {
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
                    .frame(width: (size.width - 30)/2, height: size.height)
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.white)
                            .matchedGeometryEffect(id: poll.id, in: animation)
                            .shadow(color: Color(.systemGray).opacity(0.3), radius: 8, x: 5, y: 5)
                            .shadow(color: Color(.systemGray).opacity(0.3), radius: 8, x: -5, y: -5)

                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(poll.question)
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text("By: \(poll.author)")
                            .font(.caption)
                            .foregroundStyle(.gray)
                                                    
                        HStack(spacing: 4) {
                            Text("\(poll.votes.reduce(0, +))")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundStyle(.blue)
                            
                            Text((poll.votes.reduce(0, +)) == 1 ? "Vote" : "Votes")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        
                    }

                }
                
            }
            .frame(height: 220)
            
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 25) {
                    QuestionView()
                    
                    ForEach(poll.chat) { message in
                        MessageView(message: message)
                    }
                    
                }
                
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background {
            Rectangle()
                .fill(.white)
                .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    func QuestionView() -> some View {
        
        VStack(alignment: .leading, spacing: 15) {
            
            Text(poll.trip)
                .font(.callout)
                .foregroundStyle(.gray)
                .frame(alignment: .leading)
            
            HStack {
                Text(poll.question)
                    .font(.title3)
                    .fontWeight(.semibold)
                .foregroundStyle(.black)
                
                Spacer()
                
                if option_selected {
                    Button(action: {
                        option_selected = false
                        selected_option = ""
                    }, label: {
                        Image(systemName: "arrow.uturn.backward")
                            .padding(.trailing, 10)
                    })
                }
                
            }
            
            VStack(spacing: 12) {
                ForEach(poll.options, id:\.self) { option in
                    
                    ZStack {
                        OptionView(option, .gray)
                            .opacity(option_selected && selected_option == option ? 0 : 1)
                        OptionView(option, .blue)
                            .opacity(option_selected && selected_option == option ? 1 : 0)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if !option_selected {
                            withAnimation(.easeInOut) {
                                option_selected = true
                                selected_option = option
                            }
                        }
                    }
                }
            }
            .padding(.vertical, 10)
        }
        .padding(15)
        .frame(alignment: .center)
        .background {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.white)
        }
        .padding(.horizontal, 15)
    }
    
    @ViewBuilder
    func OptionView(_ option: String, _ tint: Color) -> some View {
        
        Text(option)
            .frame(width: 300)
            .foregroundStyle(tint)
            .padding(.horizontal, 15)
            .padding(.vertical, 20)
            .frame(alignment: .leading)
            .background {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(tint.opacity(0.15))
                    .background {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(tint.opacity(tint == .gray ? 0.15 : 1), lineWidth: 2)
                }
         }
    }}

#Preview {
    PollsView()
}
