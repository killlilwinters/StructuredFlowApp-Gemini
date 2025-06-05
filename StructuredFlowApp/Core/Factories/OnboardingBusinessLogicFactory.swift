//
//  OnboardingFlowBusinessLogicFactory.swift
//  StructuredFlowApp
//
//  Created by Gemini 2.5 Pro on 04.06.2025.
//

import Foundation

@MainActor // Ensure this is present
class OnboardingFlowBusinessLogicFactory {
    init() {}

    func makeOnboardingWelcomeViewModel(flowDelegate: OnboardingStepFlowDelegate) -> OnboardingWelcomeViewModel {
        OnboardingWelcomeViewModel(flowDelegate: flowDelegate)
    }

    func makeOnboardingTermsViewModel(flowDelegate: OnboardingStepFlowDelegate) -> OnboardingTermsViewModel {
        OnboardingTermsViewModel(flowDelegate: flowDelegate)
    }

    func makeOnboardingCompleteViewModel(flowDelegate: OnboardingStepFlowDelegate) -> OnboardingCompleteViewModel {
        OnboardingCompleteViewModel(flowDelegate: flowDelegate)
    }
}
