//
//  OnboardingTermsViewModel.swift
//  StructuredFlowApp
//
//  Created by Gemini 2.5 Pro on 04.06.2025.
//

import SwiftUI // Import SwiftUI for Binding if providing custom bindings from VM

@MainActor
@Observable
class OnboardingTermsViewModel {
    struct State: Equatable {
        var agreedToTerms = false
        // You could add other UI state here if needed, e.g., scroll position, error message
    }
    private(set) var state: State
    private weak var flowDelegate: OnboardingStepFlowDelegate?

    init(initialState: State = State(), flowDelegate: OnboardingStepFlowDelegate?) {
        self.state = initialState
        self.flowDelegate = flowDelegate
    }

    // Setter method for the View's binding
    func setAgreedToTerms(_ agreed: Bool) {
        state.agreedToTerms = agreed
        print("Terms agreed via ViewModel: \(agreed)")
    }

    func continueButtonTapped() {
        if state.agreedToTerms {
            flowDelegate?.onboardingStepDidRequestNext()
        } else {
            // Optionally, handle the case where the user tries to continue without agreeing
            print("OnboardingTermsViewModel: Cannot continue, terms not agreed.")
        }
    }
}
