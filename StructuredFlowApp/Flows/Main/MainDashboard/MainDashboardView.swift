//
//  MainDashboardView.swift
//  StructuredFlowApp
//
//  Created by Gemini 2.5 Pro on 04.06.2025.
//

import SwiftUI

struct MainDashboardView: View {
    // ViewModel is provided by MainCoordinatorViewModel
    @State var viewModel: MainDashboardViewModel

    var body: some View {
        List {
            Section("App Features") {
                // NavigationLink using 'value' for type-based navigation.
                // The Label provides the visual content for the link.
                NavigationLink(value: MainPath.coreFunctions) {
                    Label("Core Functions", systemImage: "puzzlepiece.extension.fill")
                }
                // Example of another feature, if you had one in MainPath
                // NavigationLink(value: MainPath.anotherFeature) {
                //     Label("Another Feature", systemImage: "star.fill")
                // }
            }
            
            Section("User Management") { // Renamed for clarity
                NavigationLink(value: MainPath.settings) {
                    Label("Settings", systemImage: "gearshape.fill") // Using a filled icon
                }
                NavigationLink(value: MainPath.account) {
                    Label("My Account", systemImage: "person.crop.circle.fill") // Using a filled icon
                }
            }
            
            Section("Actions") {
                 Button {
                    // Action is handled by the ViewModel, which then delegates up
                    viewModel.requestLogout()
                 } label: {
                    // Label for the button content
                    Label("Logout", systemImage: "arrow.backward.square.fill") // Using a filled icon
                        .foregroundColor(.red) // Make logout visually distinct
                }
            }
        }
        // Optional: If the dashboard itself had a title, but MainCoordinatorView sets "Dashboard"
        // .navigationTitle("Main Hub")
        // .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    // Dummy navigator for the preview
    class DummyMainScreenNavigator: MainFlowScreenNavigator {
        func screenDidRequestNavigationTo(path: MainPath) {
            print("Preview: Dashboard requesting navigation to \(path)")
        }
        func screenDidRequestLogout() {
            print("Preview: Dashboard requesting logout")
        }
    }

    // Create an instance of MainDashboardViewModel for the preview
    let previewViewModel = MainDashboardViewModel(navigator: DummyMainScreenNavigator())

    // Wrap in NavigationStack for the preview to see NavigationLinks correctly
    return NavigationStack {
        MainDashboardView(viewModel: previewViewModel)
            .navigationTitle("Preview Dashboard") // Add a title for the preview context
    }
}
