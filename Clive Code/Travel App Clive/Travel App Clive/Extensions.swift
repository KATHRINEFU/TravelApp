//
//  ViewExtension.swift
//  Travel App Clive
//
//  Created by null-reaper on 8/20/23.
//

import SwiftUI
import MapKit

extension View {
        
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
    
    func hLeading() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func hTrailing() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    func hCenter() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
    func getSafeArea()-> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
            
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        
        return safeArea
        
    }
    
    func getRect()->CGRect {
        return UIScreen.main.bounds
    }
}

struct ShadowBox: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.06), radius: 5, x: 2, y: 2)
            .shadow(color: Color.black.opacity(0.06), radius: 5, x: -2, y: -2)
            .shadow(color: Color.black.opacity(0.06), radius: 5, x: 2, y: 2)
            .shadow(color: Color.black.opacity(0.06), radius: 5, x: -2, y: 2)
    }
}

extension CLLocationCoordinate2D {
    
    static var myLocation: CLLocationCoordinate2D {
        return .init(latitude: 37.3346, longitude: -122.0090)
    }
    
}

extension MKCoordinateRegion {
    
    static var myRegion: MKCoordinateRegion {
        return .init(center: .myLocation, latitudinalMeters: 10000, longitudinalMeters: 10000)
    }
    
}
