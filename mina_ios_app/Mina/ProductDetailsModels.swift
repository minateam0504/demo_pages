import Foundation

// Main response struct
struct ProductDetailsResponse: Codable {
    let processed: Bool
    let result: ProductResult
    let userId: String?
    
    enum CodingKeys: String, CodingKey {
        case processed
        case result
        case userId = "user_id"
    }
}

// Product details result struct
struct ProductResult: Codable {
    let objectName: String
    let objectDescription: String
    let objectCondition: String
    let safetyConsiderations: String
    let objectValue: String
    let objectBrand: String
    let objectModel: String
    let objectYear: String
    let objectFeatures: [String]
    let additionalInfo: String
    let hasRecall: Bool
    
    enum CodingKeys: String, CodingKey {
        case objectName = "ObjectName"
        case objectDescription = "ObjectDescription"
        case objectCondition = "ObjectCondition"
        case safetyConsiderations = "SafetyConsiderations"
        case objectValue = "ObjectValue"
        case objectBrand = "ObjectBrand"
        case objectModel = "ObjectModel"
        case objectYear = "ObjectYear"
        case objectFeatures = "ObjectFeatures"
        case additionalInfo = "AdditionalInfo"
        case hasRecall = "HasRecall"
    }
} 
