//
//  NextFeatureView.swift
//  StructuredFlowApp
//
//  Created by Gemini 2.5 Pro on 04.06.2025.
//

import SwiftUI

struct NextFeatureView: View {
    @State var viewModel: NextFeatureViewModel

    // Namespace for the animation, remains in the View
    @Namespace private var animationNamespace

    var body: some View {
        ZStack {
            // --- List of Cards ---
            if viewModel.state.selectedItem == nil {
                ScrollView {
                    LazyVStack(spacing: 15) {
                        ForEach(viewModel.state.items) { item in // items from viewModel
                            SmallDemoCard(item: item, namespace: animationNamespace)
                                .frame(height: 120)
                                .padding(.horizontal)
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                                        viewModel.selectItem(item) // Update viewModel
                                    }
                                }
                        }
                    }
                    .padding(.top, 10)
                }
                .transition(.asymmetric(insertion: .opacity.animation(.easeInOut(duration: 0.2)),
                                        removal: .opacity.animation(.easeInOut(duration: 0.1))))
            }

            // --- Detail View (Expanded Card) ---
            if let selectedItem = viewModel.state.selectedItem { // selectedItem from viewModel
                DetailDemoCard(item: selectedItem, namespace: animationNamespace) {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                        viewModel.deselectItem() // Update viewModel
                    }
                }
                .zIndex(1)
                .transition(.asymmetric(insertion: .opacity.animation(.easeInOut(duration: 0.1).delay(0.1)),
                                        removal: .opacity.animation(.easeInOut(duration: 0.2))))
            }
        }
        .navigationTitle("Feature Showcase")
    }
}

// MARK: - Card Subviews
struct SmallDemoCard: View {
    let item: NextFeatureView.CardType // Uses the enum type
    let namespace: Namespace.ID

    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text(item.title) // Access computed property
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(12)
        }
        .frame(maxWidth: .infinity, alignment: .bottomLeading)
        .background(
            item.color // Access computed property
                .matchedGeometryEffect(id: item.id, in: namespace) // Use enum's id
        )
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 2)
    }
}

struct DetailDemoCard: View {
    let item: NextFeatureView.CardType // Uses the enum type
    let namespace: Namespace.ID
    var dismissAction: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            item.color // Access computed property
                .matchedGeometryEffect(id: item.id, in: namespace) // Use enum's id
                .frame(height: 250)
                .overlay(
                    VStack(alignment: .leading) {
                        Spacer()
                        Text(item.title) // Access computed property
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                            .padding()
                    }
                    .frame(maxWidth: .infinity, alignment: .bottomLeading)
                )
                .onTapGesture { dismissAction() }

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Full Details")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top)

                    Text(item.detailText) // Access computed property
                        .font(.body)

                    Spacer(minLength: 20)

                    Button("Close") { dismissAction() }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.2))
                        .foregroundColor(.primary)
                        .cornerRadius(10)
                        .padding(.bottom)
                }
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemBackground))
        }
        .background(Color(.systemBackground))
        .ignoresSafeArea()
    }
}

extension NextFeatureView {
    // Enum for Card Types, nested or in the same file scope
    enum CardType: CaseIterable, Identifiable {
        case alpha, beta, gamma

        // Conformance to Identifiable
        var id: String {
            switch self {
            case .alpha: return "alpha_card"
            case .beta: return "beta_card"
            case .gamma: return "gamma_card"
            }
        }

        // Associated values provided by computed properties
        var title: String {
            switch self {
            case .alpha: return "Project Alpha"
            case .beta: return "Project Beta"
            case .gamma: return "Project Gamma"
            }
        }

        var color: Color {
            switch self {
            case .alpha: return .blue
            case .beta: return .green
            case .gamma: return .orange
            }
        }

        var detailText: String {
            switch self {
            case .alpha: return "Detailed information about Project Alpha. This project focuses on innovative solutions for modern problems using cutting-edge technology."
            case .beta: return "Exploring Project Beta: A deep dive into sustainable practices and ecological advancements. Learn how we are making a difference."
            case .gamma: return "Unveiling Project Gamma: The future of interconnected systems and smart infrastructure. Discover the potential of seamless integration."
            }
        }
    }

}
