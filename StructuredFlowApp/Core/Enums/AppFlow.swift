//
//  AppFlow.swift
//  StructuredFlowApp
//
//  Created by Gemini 2.5 Pro on 04.06.2025.
//

import Foundation

enum AppFlow: Identifiable, Hashable {
    case launch
    case onboarding
    case login
    case main

    var id: Self { self }
}
