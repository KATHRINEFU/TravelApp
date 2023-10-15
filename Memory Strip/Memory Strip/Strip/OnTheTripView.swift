//
//  OnTheTripView.swift
//  Memory Strip
//
//  Created by null-reaper on 10/13/23.
//

import SwiftUI
import PhotosUI

struct OnTheTripView: View {
    
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
    
    @State private var memories = ""

    @StateObject var photosModel: PhotosPickerModel = .init()
    
    var body: some View {
        NavigationStack {
            HStack {
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
                .frame(width: 175)
                
                Spacer(minLength: 0)
                
                VStack {
                    
                    HStack {
                        Text("Aug 8")
                            .font(.title3)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.leading, 25)
                    
                    HStack {
                        Text("07:00")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.leading, 28)

                    VStack {
                        ScrollView (.vertical, showsIndicators: false) {
                            
                            Text("Description of the event")
                                .padding(5)
                        }
                    }
                    .frame(width: 188, height: 100)
                    .background(Color(.systemGray6))
                    .clipShape(.rect(cornerRadius: 15))
                    .padding(15)
                    
                    HStack {
                        Text("Snaps")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.leading, 28)

                    VStack {
                            
                        VStack (spacing: 0) {
                            
                            if !photosModel.loadedImages.isEmpty {
                                TabView {
                                    ForEach(photosModel.loadedImages) { mediaFile in
                                        mediaFile.image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .padding(.top, 10)
                                    }
                                }
                                .tabViewStyle(.page)
                            } else {
                                Image("image_placeholder")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(.top, 10)

                            }
                            
                            Spacer()

                            PhotosPicker(selection: $photosModel.selectedPhoto, matching: .any(of: [.images]), photoLibrary: .shared()) {
                                Image(systemName: "photo.fill")
                                    .font(.callout)
                            }
                            .padding(.bottom, 10)

                        }
                            
                    }
                    .frame(width: 188, height: 120)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color(.systemGray3), style: StrokeStyle(lineWidth: 2, dash: [5]))
                    )
                    .padding(15)
                    
                    HStack {
                        Text("Memories")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.leading, 28)

                    TextEditor(text: $memories)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Button(action: {
                                    // Add bold formatting
                                }) {
                                    Image(systemName: "bold")
                                }
                                Button(action: {
                                    // Add italic formatting
                                }) {
                                    Image(systemName: "italic")
                                }
                                Button(action: {
                                    // Add underline formatting
                                }) {
                                    Image(systemName: "underline")
                                }
                            }
                        }
                        .padding(5)
                        .scrollContentBackground(.hidden)
                        .background(Color(.systemGray6))
                    .frame(width: 188, height: 178)
                    .clipShape(.rect(cornerRadius: 15))
                    .padding(15)
                    
                    Spacer()
                }
                .padding(.top, 32)

            }
            .navigationTitle("On The Trip")
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
        .frame(width: 160, height: 300)
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
    OnTheTripView()
}
