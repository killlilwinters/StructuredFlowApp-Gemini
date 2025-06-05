//
//  SettingsView.swift
//  StructuredFlowApp
//
//  Created by Gemini 2.5 Pro on 04.06.2025.
//

import SwiftUI

struct SettingsView: View {
    // ViewModel is provided by MainCoordinatorViewModel
    // We use @State here because the view receives the VM instance.
    // For bindings to properties within VM's State struct, we create custom bindings.
    @State var viewModel: SettingsViewModel

    var body: some View {
        Form {
            Section("Preferences") {
                Toggle("Enable Notifications",
                       isOn: Binding(
                           get: { viewModel.state.notificationsEnabled },
                           set: { viewModel.setNotificationsEnabled($0) } // Call VM setter
                       ))
                Toggle("Dark Mode",
                       isOn: Binding(
                           get: { viewModel.state.darkModeEnabled },
                           set: { viewModel.setDarkModeEnabled($0) } // Call VM setter
                       ))
            }

            Section("About") {
                HStack {
                    Text("App Version")
                    Spacer()
                    Text(viewModel.state.appVersion)
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Build Number")
                    Spacer()
                    Text(viewModel.state.buildNumber)
                        .foregroundColor(.gray)
                }

                NavigationLink(value: MainPath.account) { // Assuming MainPath.account can serve as an "About"
                    Label("About AppName", systemImage: "info.circle.fill")
                }

                if let privacyURL = viewModel.state.privacyPolicyURL {
                    Link(destination: privacyURL) {
                        Label("Privacy Policy", systemImage: "shield.lefthalf.filled")
                            .foregroundColor(.blue) // Make links look like links
                    }
                }

                if let termsURL = viewModel.state.termsOfServiceURL {
                    Link(destination: termsURL) {
                        Label("Terms of Service", systemImage: "doc.text.fill")
                            .foregroundColor(.blue) // Make links look like links
                    }
                }
            }

            Section("Support") {
                Button {
                    viewModel.contactSupport()
                } label: {
                    // Ensure the label is aligned like other Form rows
                    HStack {
                         Label("Contact Support", systemImage: "lifepreserver.fill")
                         Spacer() // Pushes content to the left
                    }
                    .contentShape(Rectangle()) // Makes the whole row tappable for the button
                }
                .buttonStyle(.plain) // Use plain button style in Form to make it look like a row item
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    let previewViewModel = SettingsViewModel(
        initialState: SettingsViewModel.State(
            notificationsEnabled: true,
            darkModeEnabled: false,
            appVersion: "1.0.0 (Preview)",
            buildNumber: "100P",
            privacyPolicyURL: URL(string: "https://www.example.com/privacy-preview"),
            termsOfServiceURL: URL(string: "https://www.example.com/terms-preview")
        )
    )
    return NavigationStack {
        SettingsView(viewModel: previewViewModel)
    }
}
