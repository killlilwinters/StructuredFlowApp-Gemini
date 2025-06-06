//
//  OnboardingTermsView.swift
//  StructuredFlowApp
//
//  Created by Gemini 2.5 Pro on 04.06.2025.
//

import SwiftUI

struct OnboardingTermsView: View {
    // ViewModel is passed from OnboardingCoordinatorViewModel
    // We use @State because the view receives this instance.
    // @Bindable is not used here if we are creating custom bindings to a nested State struct.
    @State var viewModel: OnboardingTermsViewModel

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "doc.text.magnifyingglass")
                .font(.system(size: 60)) // Slightly smaller icon
                .foregroundColor(.accentColor)
                .padding(.top, 20)

            Text("Terms & Conditions")
                .font(.title2) // Slightly smaller title
                .fontWeight(.semibold)

            ScrollView {
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n\nSed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.")
                    .font(.caption) // Smaller text for terms
                    .padding(.horizontal)
                    .lineSpacing(4)
            }
            .frame(maxHeight: 300) // Limit scroll view height
            .padding(.bottom, 10)

            // Custom Binding for the Toggle
            Toggle("I agree to the terms and conditions",
                   isOn: Binding(
                       get: { viewModel.state.agreedToTerms },
                       set: { viewModel.setAgreedToTerms($0) } // Call the VM's setter
                   ))
                .padding(.horizontal)
                .tint(.accentColor) // Apply accent color to the toggle switch

            Spacer() // Pushes content and button to the bottom

            Button("Continue") {
                viewModel.continueButtonTapped()
            }
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity) // Make button wider
            .padding(.horizontal)
            .padding(.bottom, 20) // Add some bottom padding
            .disabled(!viewModel.state.agreedToTerms) // Observe VM state property
        }
        .padding() // Overall padding for the VStack
        // .id(viewModel.state) // If other parts of the state might change and require full redraw
    }
}

#Preview {
    class DummyOnboardingStepDelegate: OnboardingStepFlowDelegate {
        func onboardingStepDidRequestNext() { print("Preview: Next step requested from Terms") }
        func onboardingStepDidRequestFinish() { print("Preview: Finish requested from Terms (not applicable)") }
    }

    let previewViewModel = OnboardingTermsViewModel(
        initialState: OnboardingTermsViewModel.State(agreedToTerms: false), // Start with terms not agreed
        flowDelegate: DummyOnboardingStepDelegate()
    )

    return OnboardingTermsView(viewModel: previewViewModel)
        // For better preview context if it's part of a larger flow
        // .environmentObject(OnboardingCoordinatorViewModel(completionDelegate: nil, factory: OnboardingFlowBusinessLogicFactory()))
}
