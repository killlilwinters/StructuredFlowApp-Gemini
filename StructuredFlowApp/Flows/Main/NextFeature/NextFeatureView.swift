//
//  NextFeatureView.swift
//  StructuredFlowApp
//
//  Created by Maksym Horobets on 05.06.2025.
//

import SwiftUI

struct NextFeatureView: View {
    @State var viewModel: NextFeatureViewModel
    @Namespace private var namespace
    @State private var isZoomed = false
    
    // MARK: Important
    // Regenerate this value on each close
    // and assign it as a view id (.id())
    // to refresh the view's state and avoid
    // the stale dragOffset (if it is a property of that view).
    @State private var zoomedCardId = UUID()
    
    @State private var dragOffset: CGSize = .zero
    private let dismissThreshold: CGFloat = 80
    
    private var animation: Animation {
        .spring(response: 0.55, dampingFraction: 0.82)
    }
    
    var body: some View {
        let drag = DragGesture()
            .onChanged { value in
                withAnimation(.default.speed(2)) {
                    dragOffset = CGSize(width: value.translation.width, height: max(0, value.translation.height))
                }
            }
            .onEnded { value in
                if value.translation.height > dismissThreshold {
                    withAnimation {
                        isZoomed.toggle()
                    }
                    dragOffset = .zero
                } else {
                    withAnimation(animation) {
                        dragOffset = .zero
                    }
                }
            }
        
        ZStack {
            if !isZoomed {
                UnevenRoundedRectangle(
                    cornerRadii: .init(
                        topLeading: 25,
                        bottomLeading: 0,
                        bottomTrailing: 25,
                        topTrailing: 0
                    )
                )
                .matchedGeometryEffect(id: "card", in: namespace)
                    .frame(maxWidth: .infinity, maxHeight: 80)
                    .padding()
                    .onTapGesture {
                        withAnimation(animation.speed(1.3)) {
                            isZoomed.toggle()
                        }
                    }
            } else {
                RoundedRectangle(cornerRadius: 25)
                    .fill(.clear)
                    .overlay {
                        VStack {
                            ForEach(0..<4, id: \.self) { num in
                                Button("Button") {}
                            }
                        }
                    }
                    .background {
                        RoundedRectangle(cornerRadius: 25)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .onTapGesture {
                                withAnimation(animation) {
                                    isZoomed.toggle()
                                }
                            }
                    }
                    .matchedGeometryEffect(id: "card", in: namespace)
                    .offset(y: dragOffset.height)
                    .scaleEffect(dragOffset.height > 0 ? max(0.9, 1 - dragOffset.height / 500) : 1)
//                    .containerRelativeFrame(.vertical) { size, _ in
//                        size * max(0.6, 1 - dragOffset.height / 500)
//                    }
                    .gesture(drag)
                    .zIndex(1)
            }
        }
        .ignoresSafeArea()
        .navigationTitle("Card Transition")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(isZoomed ? .hidden : .visible)
    }
}

#Preview {
    NavigationView {
        // Ensure viewModel is initialized correctly for the preview
        NextFeatureView(viewModel: NextFeatureViewModel())
    }
}
