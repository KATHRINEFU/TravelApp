//
//  EventMiniView.swift
//  Travel App Clive
//
//  Created by null-reaper on 8/20/23.
//

import SwiftUI

struct EventMiniView: View {
    
    @State var isComplete: Bool = false
    
    var body: some View {

        ZStack {
            
            VStack {
                
                Spacer()
                
                Text("Paris to Tokyo")
                    .fixedSize(horizontal: true, vertical: false)
                    .font(.system(size: 7, weight: .semibold))
                    .lineLimit(1)
                    .rotationEffect(.degrees(-90))
                    .padding(.bottom, 30)
                    .frame(height: 80, alignment: .bottom)

         
                
                Circle()
                    .frame(width: 7, height: 7)
                    .foregroundColor(Color(isComplete ? .systemGreen : .systemRed))
                    .padding(.bottom, 7)

            }

            VStack {
                
                Image(systemName: "airplane")
                    .font(.system(size: 10))
                    .foregroundColor(Color(.systemBlue))
                    .padding(.top, 7)
                    .padding(.bottom, 10)
                    .background(Color(.white))

                Spacer()
                
            }
                        
        }
        .frame(width: 25, height: 125)
        .modifier(ShadowBox())


    }
    
}

struct EventMiniView_Previews: PreviewProvider {
    static var previews: some View {
        EventMiniView()
    }
}
