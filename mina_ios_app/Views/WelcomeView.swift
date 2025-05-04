import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var isLoading = false
    @State private var showingCreateAccount = false
    @State private var showingPhoneLogin = false
    
    var body: some View {
        ZStack {
            MinaColors.cream
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Spacer()
                
                // Logo
                MinaLogo(size: .large)
                
                // Title
                Text("Welcome to Mina")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(MinaColors.charcoal)
                
                // Tagline
                Text("A smart and trusted marketplace for secondhand baby gear, designed for parents by parents.")
                    .font(.system(size: 18))
                    .multilineTextAlignment(.center)
                    .foregroundColor(MinaColors.charcoal)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 20)
                
                // Create account button
                Button(action: {
                    showingCreateAccount = true
                }) {
                    Text("Create an Account")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                }
                .background(MinaColors.terracotta)
                .cornerRadius(24)
                .padding(.horizontal, 32)
                
                // Phone login button
                SocialLoginButton(type: .phone) {
                    showingPhoneLogin = true
                }
                .padding(.horizontal, 32)
                
                // Divider
                HStack {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.gray.opacity(0.3))
                    
                    Text("or continue with")
                        .font(.system(size: 14))
                        .foregroundColor(Color.gray)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.gray.opacity(0.3))
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 8)
                
                // Social login buttons
                VStack(spacing: 12) {
                    SocialLoginButton(type: .google) {
                        loginWithGoogle()
                    }
                    
                    SocialLoginButton(type: .facebook) {
                        loginWithFacebook()
                    }
                    
                    SocialLoginButton(type: .apple) {
                        loginWithApple()
                    }
                }
                .padding(.horizontal, 32)
                
                // Sign in link
                HStack {
                    Text("Already have an account?")
                        .font(.system(size: 14))
                        .foregroundColor(Color.gray)
                    
                    Button(action: {
                        // Handle sign in
                    }) {
                        Text("Sign in")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(MinaColors.terracotta)
                    }
                }
                .padding(.top, 12)
                
                // Terms text
                Text("By continuing, you agree to our Terms of Service and Privacy Policy")
                    .font(.system(size: 12))
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                
                Spacer()
            }
            
            if isLoading {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                
                ProgressView()
                    .scaleEffect(1.5)
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            }
        }
        .sheet(isPresented: $showingCreateAccount) {
            Text("Create Account Screen")
                .environmentObject(authManager)
        }
        .sheet(isPresented: $showingPhoneLogin) {
            Text("Phone Login Screen")
                .environmentObject(authManager)
        }
    }
    
    // MARK: - Authentication Methods
    
    private func loginWithGoogle() {
        isLoading = true
        
        // In a real app, this would use UIApplication.shared.windows.first?.rootViewController
        // to get the view controller for Google Sign In
        let viewController = UIViewController()
        
        authManager.signInWithGoogle(presentingViewController: viewController) { result in
            isLoading = false
            
            switch result {
            case .success(let user):
                print("Successfully logged in with Google: \(user.name ?? "")")
            case .failure(let error):
                print("Google login error: \(error.localizedDescription)")
            }
        }
    }
    
    private func loginWithFacebook() {
        isLoading = true
        
        let viewController = UIViewController()
        
        authManager.signInWithFacebook(presentingViewController: viewController) { result in
            isLoading = false
            
            switch result {
            case .success(let user):
                print("Successfully logged in with Facebook: \(user.name ?? "")")
            case .failure(let error):
                print("Facebook login error: \(error.localizedDescription)")
            }
        }
    }
    
    private func loginWithApple() {
        isLoading = true
        
        authManager.signInWithApple { result in
            isLoading = false
            
            switch result {
            case .success(let user):
                print("Successfully logged in with Apple: \(user.name ?? "")")
            case .failure(let error):
                print("Apple login error: \(error.localizedDescription)")
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
            .environmentObject(AuthManager())
    }
}
