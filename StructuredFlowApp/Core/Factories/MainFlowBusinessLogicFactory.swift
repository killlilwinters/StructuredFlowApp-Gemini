//
//  MainFlowBusinessLogicFactory.swift
//  StructuredFlowApp
//
//  Created by Gemini 2.5 Pro on 04.06.2025.
//

import Foundation

@MainActor // Ensure this is present
class MainFlowBusinessLogicFactory {
    init() {}

    func makeMainDashboardViewModel(navigator: MainFlowScreenNavigator) -> MainDashboardViewModel {
        MainDashboardViewModel(navigator: navigator)
    }

    func makeCoreFunctionsViewModel(navigator: MainFlowScreenNavigator) -> CoreFunctionsViewModel {
        CoreFunctionsViewModel(navigator: navigator)
    }

    func makeSettingsViewModel() -> SettingsViewModel {
        SettingsViewModel()
    }

    func makeAccountViewModel() -> AccountViewModel {
        AccountViewModel()
    }

    func makeNextFeatureViewModel() -> NextFeatureViewModel {
        NextFeatureViewModel()
    }
}
