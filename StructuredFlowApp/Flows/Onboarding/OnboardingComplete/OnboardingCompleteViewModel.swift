//
//  OnboardingCompleteViewModel.swift
//  StructuredFlowApp
//
//  Created by Gemini 2.5 Pro on 04.06.2025.
//

import Foundation

@MainActor
@Observable
class OnboardingCompleteViewModel {
    private weak var flowDelegate: OnboardingStepFlowDelegate?

    init(flowDelegate: OnboardingStepFlowDelegate?) {
        self.flowDelegate = flowDelegate
    }

    func finishButtonTapped() {
        flowDelegate?.onboardingStepDidRequestFinish()
    }
}
