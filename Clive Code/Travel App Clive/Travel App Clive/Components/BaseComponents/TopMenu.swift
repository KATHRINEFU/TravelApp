//
//  TopMenu.swift
//  Travel App Clive
//
//  Created by null-reaper on 8/20/23.
//

import SwiftUI

struct TopMenu: View {
    
    @State var text: String = "Get up and meet at 8 at the lobby!"
    @State var font: UIFont = .systemFont(ofSize: 16, weight: .regular)

    var body: some View {
        
        VStack {
            
            HStack {
                            
                Button(action: {}, label: {
                
                    Image(systemName: "house")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(.black)

                })

                Spacer()
                
                Button(action: {}, label: {                    

                    NotificationBar(text: text, font: font)

                })

                Spacer()

                Button(action: {}, label: {
                    
                    Image(systemName: "person")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(.black)

                })

            }
            .overlay {
                
            }
            .padding(.horizontal)
            .background(
                Color(.systemGray6)
            )

            Spacer()
                        
        }
        
    }
    
}

struct TopMenu_Previews: PreviewProvider {
    static var previews: some View {
        Base()
    }
}
