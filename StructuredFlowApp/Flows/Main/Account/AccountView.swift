//
//  AccountView.swift
//  StructuredFlowApp
//
//  Created by Gemini 2.5 Pro on 04.06.2025.
//

import SwiftUI

struct AccountView: View {
    @State var viewModel: AccountViewModel

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.circle.fill") // ...
            Text("User Profile").font(.title) // ...
            Text("Email: \(viewModel.userEmail)") // Use VM property
            Button("Edit Profile") {} // ...
            Spacer()
        }
        .padding().navigationTitle("My Account")
    }
}
