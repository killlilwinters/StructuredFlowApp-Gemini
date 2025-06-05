//
//  NextFeatureViewModel.swift
//  StructuredFlowApp
//
//  Created by Gemini 2.5 Pro on 04.06.2025.
//

import Foundation

// MARK: - ViewModel Definition
@MainActor
@Observable
class NextFeatureViewModel {
    struct State {

    }

    private(set) var state: State

    init(state: State = State()) {
        self.state = state
    }

}
