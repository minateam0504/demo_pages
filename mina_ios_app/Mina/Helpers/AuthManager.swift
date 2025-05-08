import Foundation
import SwiftUI

class AuthManager: NSObject, ObservableObject {
    @Published var currentUser: User?
    @Published var isAuthenticated = false
    @Published var isLoading = false
    @Published var error: Error?
    
    static let shared = AuthManager()
    
    // MARK: - Sign In with Email
    func createAccount(email: String, password: String, fullName: String? = nil, phoneNumber: String? = nil, completion: @escaping (Result<User, Error>) -> Void) {
        // In a real app, this would create a new user in the database
        // For now, we'll just create a dummy user
        let user = User(
            email: email,
            name: fullName,
            phoneNumber: phoneNumber,
            authProvider: .email
        )
        self.currentUser = user
        self.isAuthenticated = true
        completion(.success(user))
    }
    
    // MARK: - Sign In with Phone Number
    func signInWithPhone(phoneNumber: String, completion: @escaping (Result<User, Error>) -> Void) {
        // In a real app, this would verify a phone number and create/login a user
        // For now, we'll just create a dummy user
        let user = User(phoneNumber: phoneNumber, authProvider: .phone)
        self.currentUser = user
        self.isAuthenticated = true
        completion(.success(user))
    }
    
    // MARK: - Sign Out
    func signOut() {
        self.currentUser = nil
        self.isAuthenticated = false
    }
}
