//
//  TopMenu.swift
//  Travel App Clive
//
//  Created by null-reaper on 8/20/23.
//

import SwiftUI

struct TopMenu: View {
    
    @State var font: UIFont = .systemFont(ofSize: 16, weight: .regular)
    @Binding var showNotifications: Bool
    @Binding var notification: Message

    var body: some View {
        
        VStack {
            
            HStack {
                            
                Button(action: {}, label: {
                
                    Image(systemName: "house")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(.black)

                })

                Spacer()
                
                Button(action: {
                    showNotifications = true
                }, label: {

                    NotificationBar(text: "\(notification.user_name):  \(notification.text)", font: font)

                })

                Spacer()

                Button(action: {}, label: {
                    
                    Image(systemName: "person")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(.black)

                })

            }
            .ignoresSafeArea()
            .padding(.horizontal)
            .padding(.top, getSafeArea().top)
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
            .environmentObject(EventStore())
    }
}
