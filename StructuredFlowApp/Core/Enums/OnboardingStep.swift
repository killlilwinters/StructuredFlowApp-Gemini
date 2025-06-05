//
//  OnboardingStep.swift
//  StructuredFlowApp
//
//  Created by Gemini 2.5 Pro on 04.06.2025.
//

import Foundation

enum OnboardingStep: Identifiable, Hashable {
    case welcome
    case terms
    case complete

    var id: Self { self }
}
