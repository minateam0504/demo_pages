import Foundation
import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class AuthManager: NSObject, ObservableObject {
    @Published var currentUser: User?
    @Published var isAuthenticated = false
    @Published var isLoading = false
    @Published var error: Error?
    
    static let shared = AuthManager()
    private let db = Firestore.firestore()
    
    override init() {
        super.init()
        // Listen for auth state changes
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            if let firebaseUser = user {
                self?.fetchUserData(userId: firebaseUser.uid)
            } else {
                self?.currentUser = nil
                self?.isAuthenticated = false
            }
        }
    }
    
    // MARK: - Sign In with Email
    func createAccount(email: String, password: String, fullName: String? = nil, phoneNumber: String? = nil, completion: @escaping (Result<User, Error>) -> Void) {
        isLoading = true
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                self?.isLoading = false
                self?.error = error
                completion(.failure(error))
                return
            }
            
            guard let firebaseUser = authResult?.user else {
                self?.isLoading = false
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to create user"])))
                return
            }
            
            // Create user document in Firestore
            let userData: [String: Any] = [
                "email": email,
                "name": fullName ?? "",
                "phoneNumber": phoneNumber ?? "",
                "authProvider": "email",
                "createdAt": FieldValue.serverTimestamp()
            ]
            
            self?.db.collection("users").document(firebaseUser.uid).setData(userData) { error in
                self?.isLoading = false
                
                if let error = error {
                    self?.error = error
                    completion(.failure(error))
                    return
                }
                
                let user = User(
                    id: firebaseUser.uid,
                    email: email,
                    name: fullName,
                    phoneNumber: phoneNumber,
                    authProvider: .email
                )
                
                self?.currentUser = user
                self?.isAuthenticated = true
                completion(.success(user))
            }
        }
    }
    
    // MARK: - Sign In with Email
    func signInWithEmail(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        isLoading = true
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            self?.isLoading = false
            
            if let error = error {
                self?.error = error
                completion(.failure(error))
                return
            }
            
            guard let firebaseUser = authResult?.user else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to sign in"])))
                return
            }
            
            self?.fetchUserData(userId: firebaseUser.uid, completion: completion)
        }
    }
    
    // MARK: - Sign Out
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.currentUser = nil
            self.isAuthenticated = false
        } catch {
            self.error = error
        }
    }
    
    // MARK: - Private Methods
    private func fetchUserData(userId: String, completion: ((Result<User, Error>) -> Void)? = nil) {
        db.collection("users").document(userId).getDocument { [weak self] document, error in
            if let error = error {
                self?.error = error
                completion?(.failure(error))
                return
            }
            
            guard let document = document, document.exists,
                  let data = document.data() else {
                completion?(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User data not found"])))
                return
            }
            
            let user = User(
                id: userId,
                email: data["email"] as? String,
                name: data["name"] as? String,
                phoneNumber: data["phoneNumber"] as? String,
                authProvider: .email
            )
            
            self?.currentUser = user
            self?.isAuthenticated = true
            completion?(.success(user))
        }
    }
}
