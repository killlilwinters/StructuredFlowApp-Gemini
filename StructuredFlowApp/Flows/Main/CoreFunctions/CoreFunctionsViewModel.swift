//
//  CoreFunctionsViewModel.swift
//  StructuredFlowApp
//
//  Created by Gemini 2.5 Pro on 04.06.2025.
//

import Foundation

@MainActor
@Observable
class CoreFunctionsViewModel {
    private weak var navigator: MainFlowScreenNavigator?

    init(navigator: MainFlowScreenNavigator?) {
        self.navigator = navigator
    }

    func navigateToNextFeature() {
        navigator?.screenDidRequestNavigationTo(path: .nextFeature)
    }
    
    func navigateToSettingsProgrammatically() {
        navigator?.screenDidRequestNavigationTo(path: .settings)
    }
}
