//
//  AfterTripView.swift
//  Memory Strip
//
//  Created by null-reaper on 10/13/23.
//

import SwiftUI

struct AfterTripView: View {
    
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
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack (spacing: 10) {
                            ForEach(cards) { card in
                                CardView(card)
                            }
                        }
                        .padding(.trailing, size.height - 390)
                        .scrollTargetLayout()
                    }
                    .clipShape(.rect(cornerRadius: 25))
                    .scrollTargetBehavior(.viewAligned)
                }
                .padding(.horizontal, 15)
                .padding(.top, 30)
                .frame(width: 350)
                
                Spacer(minLength: 0)
                
                HStack (spacing: 25) {
                    
                    Button(action: {}, label: {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundStyle(Color.black)
                    })
                    Button(action: {}, label: {
                        Image(systemName: "camera.on.rectangle")
                            .foregroundStyle(Color.black)
                    })
                    
                    Spacer()

                    Button(action: {}, label: {
                        Image(systemName: "video.badge.plus.fill")
                            .foregroundStyle(Color.black)
                    })
                    Button(action: {}, label: {
                        Image(systemName: "doc.append")
                            .foregroundStyle(Color.black)
                    })

                }
                .frame(height: 20)
                .padding(.top, 20)
                .padding(.horizontal, 80)
            }
            .navigationTitle("After Trip")
        }
    }
    
    @ViewBuilder
    func CardView(_ card: Card) -> some View {
        GeometryReader {
            let size = $0.size
            let minY = $0.frame(in: .scrollView).minY
            let reducingHeight = (minY / 412) * 282
            let cappedHeight = min(reducingHeight, 282)
            
            let frameHeight = size.height - (minY > 0 ? cappedHeight : -cappedHeight)
            
            Image(card.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height)
                .frame(height: frameHeight)
                .clipShape(.rect(cornerRadius: 25))
                .offset(y: minY > 0 ? 0 : -cappedHeight)
                .offset(y: -card.previousOffset)

        }
        .frame(width: 320, height: 550)
        .offsetY { offset in
            let reducingHeight = (offset / 412) * 282
            let index = cards.indexOf(card)
            
            if cards.indices.contains(index + 1) {
                cards[index + 1].previousOffset = (offset < 0 ? 0 : reducingHeight)
            }

        }
    }
    
}

#Preview {
    AfterTripView()
}
