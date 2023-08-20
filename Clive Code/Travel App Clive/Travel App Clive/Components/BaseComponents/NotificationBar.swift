//
//  NotificationBar.swift
//  Travel App Clive
//
//  Created by null-reaper on 8/20/23.
//

import SwiftUI

struct NotificationBar: View {

    @State var text: String
    var font: UIFont
    
    @State var storedSize: CGSize = .zero
    @State var offset: CGFloat = 0
    
    var body: some View {
      
        HStack {
            
            Image(systemName: "megaphone")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.black)
                .padding(.leading, 10)

            ScrollView(.horizontal, showsIndicators: false) {
                
                Text(text)
                    .font(Font(font))
                    .minimumScaleFactor(1.0)
                    .offset(x: offset)

            }
            .disabled(true)
            .onAppear {
                
                let baseText = text
                
                (1...15).forEach { _ in
                    text.append(" ")
                }
                storedSize = textSize()
                text.append(baseText)
                
                storedSize = textSize()
                
                let timing: Double = (0.02 * storedSize.width)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    
                    withAnimation(.linear(duration: timing)) {
                        offset = -storedSize.width
                    }
                    
                }
                
            }
            .onReceive(Timer.publish(every: ((0.02 * storedSize.width)), on: .main, in: .default).autoconnect()) { _ in
                
                offset = 0
                withAnimation(.linear(duration: (0.02 * storedSize.width))) {
                    offset = -storedSize.width
                }
                
            }
            
        }
        .frame(width: getRect().width/5*3, height: 25)
        .modifier(ShadowBox())
        .padding()


    }

    func textSize()->CGSize {
        
        let attributes = [NSAttributedString.Key.font: font]
        
        let size = (text as NSString).size(withAttributes: attributes)
        
        return size
        
    }

}

struct NotificationBar_Previews: PreviewProvider {
    
    @State static var text: String = "Get up and meet at 8 at the lobby!"
    @State static var font: UIFont = .systemFont(ofSize: 16, weight: .regular)
    
    static var previews: some View {
        NotificationBar(text: text, font: font)
    }
}
