import SwiftUI

struct NextFeatureView: View {
    @State var viewModel: NextFeatureViewModel
    @Namespace private var animationNamespace
    @State private var isZoomed = false
    @State private var zoomedCardId = UUID()

    private var animation: Animation {
        .spring(response: 0.55, dampingFraction: 0.82)
    }

    var body: some View {
        let rectangle = UnevenRoundedRectangle(
            cornerRadii:
                    .init(
                        topLeading: 25,
                        bottomLeading: 0,
                        bottomTrailing: 25,
                        topTrailing: 0
                    )
        )
        ZStack {
            if !isZoomed {
                Button(action: {
                    withAnimation(animation) {
                        isZoomed = true
                    }
                }) {
                    rectangle
                        .fill(Color.blue.mix(with: .black, by: 0.5))
                        .frame(height: 70)
                        .overlay(
                            ZStack {
                                rectangle
                                    .stroke(lineWidth: 3)
                                    .fill(.blue)
                                Text("Tap Me")
                                    .foregroundColor(.white)
                                    .font(.headline)
                            }
                        )
                        .matchedGeometryEffect(id: "card", in: animationNamespace)
                        .padding(.horizontal)
                }
                .padding(.vertical, 20)
            } else {
                ZoomedCardView(
                    namespace: animationNamespace,
                    animation: animation,
                    onDismiss: {
                        withAnimation(.linear) {
                            isZoomed = false
                        }
                        zoomedCardId = UUID()
                    }
                )
                // This id is needed to regenerate the view so it does not
                // have a leftover dragOffset value from the previous dimissal
                .id(zoomedCardId)
                .zIndex(1)
            }
        }
        .navigationTitle("Card Transition")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(isZoomed ? .hidden : .visible)
    }
}

struct ZoomedCardView: View {
    let namespace: Namespace.ID
    let animation: Animation // Passed from parent for consistency
    let onDismiss: () -> Void

    @State private var dragOffset: CGSize = .zero
    private let dismissThreshold: CGFloat = 80

    var body: some View {
        let drag = DragGesture()
            .onChanged { value in
                dragOffset = CGSize(width: value.translation.width, height: max(0, value.translation.height))
            }
            .onEnded { value in
                if value.translation.height > dismissThreshold {
                    onDismiss()
                } else {
                    withAnimation(animation) {
                        dragOffset = .zero
                    }
                }
            }

        ZStack {
            VStack {
                Text("Zoomed In")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .padding()

                Image(systemName: "globe")
                    .foregroundStyle(.white)
                    .font(.system(size: 144))

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.blue.mix(with: .black, by: 0.5))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .matchedGeometryEffect(id: "card", in: namespace)
        .offset(x: dragOffset.width, y: dragOffset.height)
        .scaleEffect(dragOffset.height > 0 ? max(0.95, 1 - dragOffset.height / 500) : 1)
        .containerRelativeFrame(.vertical) { size, _ in
            size * max(0.6, 1 - dragOffset.height / 500)
        }
        .gesture(drag)
    }
}

struct NextFeatureView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            // Ensure viewModel is initialized correctly for the preview
            NextFeatureView(viewModel: NextFeatureViewModel())
        }
    }
}
