//
//  TabButton.swift
//  Travel App Clive
//
//  Created by null-reaper on 8/20/23.
//

import SwiftUI

struct TabButton: View {
    
    var title: String
    var image : String
    @Binding var selected : String
    
    var body: some View {
        
        Button(action: {
            
            withAnimation(.spring()) {
                selected = title
            }
            
        }, label: {
            
            HStack(spacing: 10) {
                
                Image(systemName: image)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 25, height: 25)
                    .foregroundColor(.black)
                
                if selected == title {
                    
                    Text(title)
                        .font(.system(size: 15))
                        .foregroundColor(.black)
                    
                }
                
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(Color.black.opacity(selected == title ? 0.08 : 0))
            .clipShape(Capsule())
            
        })
        
    }
}

struct TabButton_Previews: PreviewProvider {
 
    @State static var current = "Home"

    static var previews: some View {
        Base()
    }
    
}
