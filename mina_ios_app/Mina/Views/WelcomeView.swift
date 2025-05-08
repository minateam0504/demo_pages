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
            RegisterView()
                .environmentObject(authManager)
        }
        .sheet(isPresented: $showingPhoneLogin) {
            Text("Phone Login Screen")
                .environmentObject(authManager)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
            .environmentObject(AuthManager())
    }
}
