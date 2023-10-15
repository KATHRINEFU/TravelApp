//
//  ContentView.swift
//  TravelApp
//
//  Created by KateFu on 8/13/23.
//

import SwiftUI
import UIKit

public struct ScrollableView<Content: View>: UIViewControllerRepresentable {
    @Binding var offset: CGPoint
    var isHorizontal: Bool
    var content: () -> Content

    public init(_ offset: Binding<CGPoint>,isHorizontal: Bool, @ViewBuilder content: @escaping () -> Content) {
        self._offset = offset
        self.isHorizontal = isHorizontal
        self.content = content
    }

    public func makeUIViewController(context: Context) -> UIScrollViewViewController {
        let vc = UIScrollViewViewController()
        vc.hostingController.rootView = AnyView(self.content())
        vc.scrollView.setContentOffset(offset, animated: false)
        vc.delegate = context.coordinator
        return vc
    }

    public func updateUIViewController(_ viewController: UIScrollViewViewController, context: Context) {
        viewController.hostingController.rootView = AnyView(self.content())

        // Allow for deaceleration to be done by the scrollView
        if !viewController.scrollView.isDecelerating {
            if isHorizontal {
                viewController.scrollView.setContentOffset(CGPoint(x: offset.x, y: viewController.scrollView.contentOffset.y), animated: false)
            } else {
                viewController.scrollView.setContentOffset(CGPoint(x: viewController.scrollView.contentOffset.x, y: offset.y), animated: false)
            }
        }
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(contentOffset: _offset)
    }

    public class Coordinator: NSObject, UIScrollViewDelegate {
        let contentOffset: Binding<CGPoint>

        init(contentOffset: Binding<CGPoint>) {
            self.contentOffset = contentOffset
        }

        public func scrollViewDidScroll(_ scrollView: UIScrollView) {
            DispatchQueue.main.async{ [self] in
                contentOffset.wrappedValue = scrollView.contentOffset
            }
        }
    }
}

public class UIScrollViewViewController: UIViewController {
    lazy var scrollView: UIScrollView = UIScrollView()

    var hostingController: UIHostingController<AnyView> = UIHostingController(rootView: AnyView(EmptyView()))

    weak var delegate: UIScrollViewDelegate?

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.delegate = delegate
        self.view.addSubview(self.scrollView)
        self.pinEdges(of: self.scrollView, to: self.view)
        self.hostingController.willMove(toParent: self)
        self.scrollView.addSubview(self.hostingController.view)
        self.pinEdges(of: self.hostingController.view, to: self.scrollView)
        self.hostingController.didMove(toParent: self)
    }

    func pinEdges(of viewA: UIView, to viewB: UIView) {
        viewA.translatesAutoresizingMaskIntoConstraints = false
        viewB.addConstraints([
            viewA.leadingAnchor.constraint(equalTo: viewB.leadingAnchor),
            viewA.trailingAnchor.constraint(equalTo: viewB.trailingAnchor),
            viewA.topAnchor.constraint(equalTo: viewB.topAnchor),
            viewA.bottomAnchor.constraint(equalTo: viewB.bottomAnchor),
        ])
    }
}

struct VTimeline: View{
    let hours: [String] = ["12 AM", "1 AM", "2 AM", "3 AM", "4 AM", "5 AM", "6 AM", "7 AM", "8 AM", "9 AM", "10 AM", "11 AM", "12 PM", "1 PM", "2 PM", "3 PM", "5 PM", "6 PM", "7 PM", "8 PM", "9 PM", "10 PM", "11 PM"]

    var body: some View {
        HStack {
            VStack(spacing: 24) {
                ForEach(hours, id: \.self) { hour in
                    HStack {
                        Text(hour)
                            .font(Font.custom("", size: 12))
                            .frame(width: 50, height: 40, alignment: .center)
                        VStack {
                            Divider()
                        }
                    }
                }
            }
            Spacer()
        }
    }
}

struct HTimeline: View{
    let hours: [String] = ["12 AM", "1AM", "2 AM", "3 AM", "4 AM", "5 AM", "6 AM", "7 AM", "8 AM", "9 AM", "10 AM", "11 AM", "12 PM", "1 PM", "2 PM", "3 PM", "5 PM", "6 PM", "7 PM", "8 PM", "9 PM", "10 PM", "11 PM"]
        
    var body: some View {
        HStack(spacing: 24) {
            ForEach(hours, id: \.self) { hour in
                VStack {
                    Text(hour)
                        .font(Font.custom("", size: 12))
                        .frame(width: 40, height: 50, alignment: .center)
                    Divider()
                }
            }
        }
    }
}

func calculatePosition(for event: Event) -> CGPoint {
    print(event)
    let hourWidth = CGFloat(30.0)
    let calendar = Calendar.current
    let startHourComponent = calendar.component(.hour, from: event.startTime)
    let endHourComponent = calendar.component(.hour, from: event.endTime)


    let startX = CGFloat(startHourComponent) * hourWidth
    let startY = CGFloat(endHourComponent) * hourWidth
    return CGPoint(x: startX, y: startY)
}


struct EventsView: View {
    @State var horizontalOffset: CGPoint = .init(x: 0, y: 0)
    @State var verticalOffset: CGPoint = .init(x: 0, y: 0)
    
    @State private var isEventMaxViewPresented = false
    @EnvironmentObject var eventStore: EventStore

    var body: some View {
        ZStack{
            VStack {
                ScrollableView($horizontalOffset, isHorizontal: true, content: {
                    HTimeline()
                })
                .onChange(of: verticalOffset) { oldValue, newValue in
                    horizontalOffset.x = newValue.y
                }
                .frame(height: 200.0)
                
                GeometryReader {geometry in
                    HStack(spacing: 5){
                        ScrollableView($verticalOffset, isHorizontal: false, content: {
                            VTimeline()
                        })
                        .onChange(of: horizontalOffset) { oldValue, newValue in
                            verticalOffset.y = newValue.x
                        }
                        .frame(width: geometry.size.width * 0.33, height: 500.0)
                        
                    }
                }
            }
            
            
            Button(action: {
                isEventMaxViewPresented.toggle()
            }) {
                Image(systemName: "plus.circle.fill") // You can use a different image here
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                    .padding()
            }
            .position(x: UIScreen.main.bounds.width - 80, y: UIScreen.main.bounds.height - 300)
            .sheet(isPresented: $isEventMaxViewPresented) {
                            EventMaxView()
                        }
        }
        .padding()
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView()
    }
}

