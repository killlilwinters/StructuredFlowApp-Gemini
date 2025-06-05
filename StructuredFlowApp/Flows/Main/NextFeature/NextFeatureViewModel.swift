//
//  NextFeatureViewModel.swift
//  StructuredFlowApp
//
//  Created by Gemini 2.5 Pro on 04.06.2025.
//

import Foundation

// MARK: - ViewModel Definition
@MainActor
@Observable // Swift 5.9+ Observation
class NextFeatureViewModel {
    struct State {
        var items: [NextFeatureView.CardType] = NextFeatureView.CardType.allCases
        var selectedItem: NextFeatureView.CardType? = nil
    }

    private(set) var state: State

    init(state: State = State()) {
        self.state = state
    }

    func selectItem(_ item: NextFeatureView.CardType?) {
        state.selectedItem = item
    }

    func deselectItem() {
        state.selectedItem = nil
    }
}
