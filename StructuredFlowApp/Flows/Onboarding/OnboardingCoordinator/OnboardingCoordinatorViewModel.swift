//
//  OnboardingCoordinatorViewModel.swift
//  StructuredFlowApp
//
//  Created by Gemini 2.5 Pro on 04.06.2025.
//

import SwiftUI

@MainActor // This ViewModel manages UI state and creates other UI ViewModels
@Observable
class OnboardingCoordinatorViewModel {
    struct State: Equatable { // Equatable is good for state if you might .id() views on it
        var currentStep: OnboardingStep = .welcome
    }

    private(set) var state: State
    private weak var completionDelegate: OnboardingCompletionDelegate? // To notify when onboarding finishes
    private let factory: OnboardingFlowBusinessLogicFactory // To create ViewModels for each step

    init(
        initialState: State = State(),
        completionDelegate: OnboardingCompletionDelegate?,
        factory: OnboardingFlowBusinessLogicFactory
    ) {
        self.state = initialState
        self.completionDelegate = completionDelegate
        self.factory = factory
        print("OnboardingCoordinatorViewModel initialized with step: \(self.state.currentStep)")
    }

    // Private method to mutate the current step in the state
    private func updateCurrentStep(_ newStep: OnboardingStep) {
        state.currentStep = newStep
        print("Onboarding step changed to: \(newStep)")
    }

    // --- Factory methods for creating ViewModels for each onboarding step ---
    // These methods use the injected 'factory' to create the specific ViewModels,
    // passing 'self' as the OnboardingStepFlowDelegate so that step VMs can communicate back.

    func makeWelcomeViewModel() -> OnboardingWelcomeViewModel {
        return factory.makeOnboardingWelcomeViewModel(flowDelegate: self)
    }

    func makeTermsViewModel() -> OnboardingTermsViewModel {
        // Ensure the factory method for terms VM also takes the flowDelegate
        return factory.makeOnboardingTermsViewModel(flowDelegate: self)
    }

    func makeCompleteViewModel() -> OnboardingCompleteViewModel {
        // Ensure the factory method for complete VM also takes the flowDelegate
        return factory.makeOnboardingCompleteViewModel(flowDelegate: self)
    }
}

// Conformance to OnboardingStepFlowDelegate allows individual step ViewModels
// to notify this coordinator to advance the step or finish the flow.
extension OnboardingCoordinatorViewModel: OnboardingStepFlowDelegate {
    func onboardingStepDidRequestNext() {
        switch state.currentStep {
        case .welcome:
            updateCurrentStep(.terms)
        case .terms:
            updateCurrentStep(.complete)
        case .complete:
            // If already at complete, 'next' doesn't make sense.
            // The 'finish' action should be triggered from OnboardingCompleteViewModel.
            print("OnboardingCoordinatorViewModel: Already at complete step. 'Finish' should be requested.")
            break
        }
    }

    func onboardingStepDidRequestFinish() {
        // This is called by OnboardingCompleteViewModel when its "finish" action is triggered.
        print("OnboardingCoordinatorViewModel: Finishing onboarding sequence via delegate.")
        // Notify the AppFlowCoordinatorViewModel that onboarding is done.
        completionDelegate?.onboardingDidComplete(navigateToLogin: true) // Example: navigate to login next
    }
}
