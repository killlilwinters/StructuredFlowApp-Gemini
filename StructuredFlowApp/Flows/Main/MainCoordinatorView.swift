//
//  MainCoordinatorView.swift
//  StructuredFlowApp
//
//  Created by Gemini 2.5 Pro on 04.06.2025.
//

import SwiftUI

struct MainCoordinatorView: View {
    @State var viewModel: MainCoordinatorViewModel

    var body: some View {
        // REMOVED the outer, redundant NavigationStack
        NavigationStack(path: Binding(
            get: { viewModel.state.navigationPath },
            set: { viewModel.setNavigationPath($0) }
        )) {
            MainDashboardView(viewModel: viewModel.makeDashboardViewModel())
                .navigationTitle("Dashboard")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) { // Changed to navigationBarLeading as per convention
                        Button {
                            viewModel.screenDidRequestLogout()
                        } label: {
                            Image(systemName: "arrow.left.square")
                            Text("Logout")
                        }
                    }
                }
                .navigationDestination(for: MainPath.self) { pathValue in
                    switch pathValue {
                    case .coreFunctions:
                        CoreFunctionsView(viewModel: viewModel.makeCoreFunctionsViewModel())
                    case .settings:
                        SettingsView(viewModel: viewModel.makeSettingsViewModel())
                    case .account:
                        AccountView(viewModel: viewModel.makeAccountViewModel())
                    case .nextFeature:
                        NextFeatureView(viewModel: viewModel.makeNextFeatureViewModel())
                    }
                }
        }
    }
}

#Preview {
    // Dummy delegate for the preview
    class DummyMainFlowNavDelegate: MainFlowNavigationDelegate {
        func mainFlowDidRequestLogout() { print("Preview: Logout requested") }
    }

    // Factory instance for the preview.
    // Since MainFlowBusinessLogicFactory is @MainActor, this is fine in a preview context.
    let mainFactory = MainFlowBusinessLogicFactory()

    // Initialize the ViewModel with the delegate and the factory
    let previewViewModel = MainCoordinatorViewModel(
        // initialState can use its default: initialState: MainCoordinatorViewModel.State(),
        navigationDelegate: DummyMainFlowNavDelegate(),
        factory: mainFactory
    )

    return MainCoordinatorView(viewModel: previewViewModel)
}
