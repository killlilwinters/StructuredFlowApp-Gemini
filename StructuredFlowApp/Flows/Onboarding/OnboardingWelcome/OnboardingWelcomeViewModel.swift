//
//  OnboardingWelcomeViewModel.swift
//  StructuredFlowApp
//
//  Created by Gemini 2.5 Pro on 04.06.2025.
//

import Foundation

@MainActor
@Observable
class OnboardingWelcomeViewModel {
    private weak var flowDelegate: OnboardingStepFlowDelegate?

    init(flowDelegate: OnboardingStepFlowDelegate?) {
        self.flowDelegate = flowDelegate
    }

    func nextButtonTapped() {
        flowDelegate?.onboardingStepDidRequestNext()
    }
}
