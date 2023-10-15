//
//  PlanningView.swift
//  Memory Strip
//
//  Created by null-reaper on 10/13/23.
//

import SwiftUI

struct PlanningView: View {
    
    @State private var cards: [Card] = [
        .init(image: "akira"),
        .init(image: "morgana"),
        .init(image: "ryuji"),
        .init(image: "ann"),
        .init(image: "yusuke"),
        .init(image: "makoto"),
        .init(image: "haru"),
        .init(image: "futaba"),
        .init(image: "goro"),
        .init(image: "kasumi")

    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                GeometryReader {
                    let size = $0.size
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack (spacing: 10) {
                            ForEach(cards) { card in
                                CardView(card)
                            }
                        }
                        .padding(.trailing, size.width - 180)
                        .scrollTargetLayout()
                    }
                    .clipShape(.rect(cornerRadius: 25))
                    .scrollTargetBehavior(.viewAligned)
                }
                .padding(.horizontal, 15)
                .padding(.top, 30)
                .frame(height: 210)
                
                Spacer(minLength: 30)
                
                VStack {
                    ScrollView (.vertical, showsIndicators: false) {
                        
                        VStack (spacing: 15) {
                            
                            ForEach(1...10, id:\.self) { _ in
                                Text("")
                                    .padding(10)
                                    .frame(width: 340, height: 80)
                                    .background(Color.white)
                                    .clipShape(.rect(cornerRadius: 15))
                                    .padding(.top, 20)
                            }
                        }
                        
                    }
                }
                .frame(width: 360, height: 400)
                .background(Color(.systemGray6))
                .clipShape(.rect(cornerRadius: 15))
                .padding(15)


            }
            .navigationTitle("Planning")
        }
    }
    
    @ViewBuilder
    func CardView(_ card: Card) -> some View {
        GeometryReader {
            let size = $0.size
            let minX = $0.frame(in: .scrollView).minX
            let reducingWidth = (minX / 190) * 130
            let cappedWidth = min(reducingWidth, 130)
            
            let frameWidth = size.width - (minX > 0 ? cappedWidth : -cappedWidth)
            
            Image(card.image)
                .resizable()	
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height)
                .frame(width: frameWidth)
                .clipShape(.rect(cornerRadius: 25))
                .offset(x: minX > 0 ? 0 : -cappedWidth)
                .offset(x: -card.previousOffset)

        }
        .frame(width: 180, height: 200)
        .offsetX { offset in
            let reducingWidth = (offset / 190) * 130
            let index = cards.indexOf(card)
            
            if cards.indices.contains(index + 1) {
                cards[index + 1].previousOffset = (offset < 0 ? 0 : reducingWidth)
            }

        }
    }
    
}

#Preview {
    PlanningView()
}
