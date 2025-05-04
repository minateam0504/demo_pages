import Foundation

enum AuthProvider: String, Codable {
    case email
    case phone
    case google
    case facebook
    case apple
}

struct User: Identifiable, Codable {
    var id: String
    var email: String?
    var name: String?
    var phoneNumber: String?
    var profilePicture: String?
    var authProvider: AuthProvider
    var providerId: String?
    var createdAt: Date
    var updatedAt: Date
    
    // Additional fields that would be populated after registration
    var address: String?
    var neighborhood: String?
    var shoppingAreas: [String]?
    var paymentMethods: [String]?
    
    init(id: String = UUID().uuidString,
         email: String? = nil,
         name: String? = nil,
         phoneNumber: String? = nil,
         profilePicture: String? = nil,
         authProvider: AuthProvider,
         providerId: String? = nil) {
        self.id = id
        self.email = email
        self.name = name
        self.phoneNumber = phoneNumber
        self.profilePicture = profilePicture
        self.authProvider = authProvider
        self.providerId = providerId
        self.createdAt = Date()
        self.updatedAt = Date()
    }
}
