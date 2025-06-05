//
//  MainDashboardViewModel.swift
//  StructuredFlowApp
//
//  Created by Gemini 2.5 Pro on 04.06.2025.
//

import Foundation

@MainActor
@Observable
class MainDashboardViewModel {
    private weak var navigator: MainFlowScreenNavigator?

    init(navigator: MainFlowScreenNavigator?) {
        self.navigator = navigator
    }

    func navigateToCoreFunctions() {
        navigator?.screenDidRequestNavigationTo(path: .coreFunctions)
    }

    func navigateToSettings() {
        navigator?.screenDidRequestNavigationTo(path: .settings)
    }

    func navigateToAccount() {
        navigator?.screenDidRequestNavigationTo(path: .account)
    }
    
    func requestLogout() {
        navigator?.screenDidRequestLogout()
    }
}
