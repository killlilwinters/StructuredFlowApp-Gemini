//
//  OnboardingCoordinatorView.swift
//  StructuredFlowApp
//
//  Created by Gemini 2.5 Pro on 04.06.2025.
//

import SwiftUI

struct OnboardingCoordinatorView: View {
    // ViewModel is provided by AppFlowCoordinatorViewModel
    @State var viewModel: OnboardingCoordinatorViewModel

    var body: some View {
        VStack {
            Group {
                // Read currentStep from viewModel.state
                switch viewModel.state.currentStep {
                case .welcome:
                    OnboardingWelcomeView(viewModel: viewModel.makeWelcomeViewModel())
                case .terms:
                    OnboardingTermsView(viewModel: viewModel.makeTermsViewModel())
                case .complete:
                    OnboardingCompleteView(viewModel: viewModel.makeCompleteViewModel())
                }
            }
        }
        .animation(.default, value: viewModel.state.currentStep) // Animate based on state change
        // Add a title to the onboarding flow if desired
        // .navigationTitle("Getting Started") // Uncomment if this view is in a NavStack context
        // .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    // 1. Dummy delegate for OnboardingCompletionDelegate
    class DummyOnboardingCompletionDelegate: OnboardingCompletionDelegate {
        func onboardingDidComplete(navigateToLogin: Bool) {
            print("Preview: Onboarding complete. Navigate to login: \(navigateToLogin)")
        }
    }

    // 2. An instance of OnboardingFlowBusinessLogicFactory
    // This factory is @MainActor, which is fine for preview instantiation.
    let onboardingFactory = OnboardingFlowBusinessLogicFactory()

    // 3. An instance of OnboardingCoordinatorViewModel, providing all required parameters
    let previewViewModel = OnboardingCoordinatorViewModel(
        initialState: OnboardingCoordinatorViewModel.State(currentStep: .welcome), // Explicitly provide initial state
        completionDelegate: DummyOnboardingCompletionDelegate(),
        factory: onboardingFactory
    )

    // To test a specific step:
    // let previewViewModelSpecificStep = OnboardingCoordinatorViewModel(
    //     initialState: OnboardingCoordinatorViewModel.State(currentStep: .terms),
    //     completionDelegate: DummyOnboardingCompletionDelegate(),
    //     factory: onboardingFactory
    // )

    // If the onboarding views themselves might expect a navigation environment
    // (e.g., for titles or if they use NavigationLinks internally),
    // wrap the preview in a NavigationStack.
    return NavigationStack {
        OnboardingCoordinatorView(viewModel: previewViewModel)
        // To test a different step:
        // OnboardingCoordinatorView(viewModel: previewViewModelSpecificStep)
    }
}
