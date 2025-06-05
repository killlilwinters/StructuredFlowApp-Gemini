//
//  LaunchViewModel.swift
//  StructuredFlowApp
//
//  Created by Gemini 2.5 Pro on 04.06.2025.
//

import Foundation

@MainActor
@Observable
class LaunchViewModel {
    private weak var navigationDelegate: LaunchNavigationDelegate?

    init(navigationDelegate: LaunchNavigationDelegate?) {
        self.navigationDelegate = navigationDelegate
    }

    func goToOnboarding() {
        navigationDelegate?.launchDidRequestOnboarding()
    }

    func goToLogin() {
        navigationDelegate?.launchDidRequestLogin()
    }
    
    func goToMainApp() {
        navigationDelegate?.launchDidRequestMainApp()
    }
}
