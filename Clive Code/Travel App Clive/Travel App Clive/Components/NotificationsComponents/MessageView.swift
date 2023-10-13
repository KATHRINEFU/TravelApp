//
//  MessageView.swift
//  Travel App Clive
//
//  Created by null-reaper on 9/30/23.
//

import SwiftUI

struct MessageView: View {
    
    @State public var message: Message

    var body: some View {
        VStack {
            
            Divider()

            HStack(alignment: .top, spacing: 12) {
                
                Image(message.user_profile)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50, alignment: .leading)
                    .clipShape(Circle())
                    .padding(.leading)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(message.user_name)
                        .font(.callout)
                        .fontWeight(.semibold)
                    
                    Text(message.timestamp)
                        .font(.caption2)
                        .foregroundStyle(.gray)
                    
                    Text(message.text)
                        .textSelection(.enabled)
                        .padding(.vertical, 8)
                    
                    // Add Image
                    
                    if !message.image.isEmpty {
                        GeometryReader {
                            let size = $0.size
                            Image(message.image)
                                .resizable()
                                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                .frame(width: size.width, height: size.height)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        }
                        .frame(height: 200)
                    }
                    
                }
                
                Spacer()
            }
            .padding(.top)

        }    }
}

#Preview {
    MessageView(message: Message(user_name: "Clive Gomes", user_profile: "profile_clive", timestamp: "09/23/2023 15:25", text: "Let's meet up at the entrance!", image: "hotel_entrance"))
}
