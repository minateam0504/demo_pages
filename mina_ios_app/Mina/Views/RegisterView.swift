import SwiftUI

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authManager: AuthManager
    
    @State private var fullName: String = ""
    @State private var nickname: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    @State private var password: String = ""
    @State private var isLoading: Bool = false
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    @State private var showSuccess: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Back button
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "arrow.left")
                        Text("Back")
                            .fontWeight(.medium)
                    }
                    .foregroundColor(MinaColors.charcoal)
                }
                .padding(.top, 10)
                
                // Logo
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(MinaColors.terracotta)
                        .frame(width: 50, height: 50)
                    
                    Text("M")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                }
                
                // Heading
                VStack(alignment: .leading, spacing: 8) {
                    Text("Tell us about yourself")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(MinaColors.charcoal)
                    
                    Text("Let's start with your basic information.")
                        .font(.system(size: 16))
                        .foregroundColor(Color.gray)
                }
                
                // Progress bar
                ProgressView(value: 0.143) // 1/7 steps
                    .progressViewStyle(LinearProgressViewStyle(tint: MinaColors.terracotta))
                    .background(Color(UIColor.systemGray5))
                    .frame(height: 4)
                    .cornerRadius(2)
                
                // Form
                VStack(spacing: 20) {
                    // Full Name
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Full Name")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(MinaColors.charcoal)
                        
                        TextField("Your full name", text: $fullName)
                            .padding(14)
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(UIColor.systemGray4), lineWidth: 1)
                            )
                    }
                    
                    // Nickname
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Nickname (Optional)")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(MinaColors.charcoal)
                        
                        TextField("Choose a nickname for privacy", text: $nickname)
                            .padding(14)
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(UIColor.systemGray4), lineWidth: 1)
                            )
                        
                        HStack {
                            Image(systemName: "shield.fill")
                                .font(.system(size: 12))
                            
                            Text("Recommended for privacy when interacting with other users")
                                .font(.system(size: 12))
                        }
                        .foregroundColor(Color.gray)
                    }
                    
                    // Email
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email Address")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(MinaColors.charcoal)
                        
                        TextField("Your email address", text: $email)
                            .padding(14)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(UIColor.systemGray4), lineWidth: 1)
                            )
                    }
                    
                    // Phone Number
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Phone Number")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(MinaColors.charcoal)
                        
                        TextField("Your phone number", text: $phoneNumber)
                            .padding(14)
                            .keyboardType(.phonePad)
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(UIColor.systemGray4), lineWidth: 1)
                            )
                    }
                    
                    // Password
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Create Password")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(MinaColors.charcoal)
                        
                        SecureField("Create a secure password", text: $password)
                            .padding(14)
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(UIColor.systemGray4), lineWidth: 1)
                            )
                    }
                    
                    // Continue Button
                    Button(action: {
                        createAccount()
                    }) {
                        ZStack {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            } else {
                                Text("Continue")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                    }
                    .padding(16)
                    .background(MinaColors.terracotta)
                    .cornerRadius(24)
                    .padding(.top, 16)
                    .disabled(isLoading)
                    
                    // Step indicator
                    Text("Step 1 of 7")
                        .font(.system(size: 14))
                        .foregroundColor(Color.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 20)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
        }
        .background(MinaColors.cream.edgesIgnoringSafeArea(.all))
        .alert(isPresented: $showError) {
            Alert(
                title: Text("Error"),
                message: Text(errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .alert("Account Created", isPresented: $showSuccess) {
            Button("OK") {
                // Dismiss this screen
                presentationMode.wrappedValue.dismiss()
            }
        } message: {
            Text("Your account has been created successfully. You can now sign in.")
        }
    }
    
    private func createAccount() {
        // Validation
        if email.isEmpty || password.isEmpty || fullName.isEmpty || phoneNumber.isEmpty {
            errorMessage = "Please fill in all required fields."
            showError = true
            return
        }
        
        isLoading = true
        
        // Create account using AuthManager
        authManager.createAccount(
            email: email,
            password: password,
            fullName: fullName,
            phoneNumber: phoneNumber
        ) { result in
            isLoading = false
            
            switch result {
            case .success(let user):
                print("Account created: \(user)")
                // Show success alert
                showSuccess = true
                
            case .failure(let error):
                errorMessage = error.localizedDescription
                showError = true
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
            .environmentObject(AuthManager.shared)
    }
} 