//
//  LoginView.swift
//  StructuredFlowApp
//
//  Created by Gemini 2.5 Pro on 04.06.2025.
//

import SwiftUI

struct LoginView: View {
    @State var viewModel: LoginViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
                .font(.largeTitle)
                .padding(.bottom, 30)

            TextField("Email (e.g., test@example.com)", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .textContentType(.emailAddress)
                .textFieldStyle(.roundedBorder)

            SecureField("Password (e.g., password)", text: $viewModel.password)
                .textContentType(.password)
                .textFieldStyle(.roundedBorder)
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
            }

            if viewModel.isLoading {
                ProgressView()
                    .padding(.top)
            } else {
                Button("Log In") {
                    Task {
                        await viewModel.attemptLogin()
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding(.top)
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    class DummyLoginDelegate: LoginSuccessDelegate {
        func loginDidSucceed() { print("Preview: Login Succeeded") }
    }
    return LoginView(viewModel: .init(successDelegate: DummyLoginDelegate()))
}
