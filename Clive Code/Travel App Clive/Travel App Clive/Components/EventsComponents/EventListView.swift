//
//  EventView.swift
//  TravelApp
//
//  Created by KateFu on 8/26/23.
//

import SwiftUI

struct EventListView: View {
    var eventIcon: String = "🍔"
    var location: String = "Test Location"
    var image: UIImage?
    var screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        HStack{
            VStack {
                Text("🍔")
                    .font(.largeTitle)
                Text("Test Location")
                    .fontWeight(.semibold)
            }
            Spacer()
            
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 100)
                    .cornerRadius(10)
            } else {
                Image("upload-cloud-icon") // Default image name
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}
