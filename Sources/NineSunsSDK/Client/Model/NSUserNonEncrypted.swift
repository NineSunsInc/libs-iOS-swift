//
//  NSUserNonEncrypted.swift
//  NineSunsSDK
//
//

public struct NSUserNonEncrypted: Codable {
  let username: String?
  let isDevelop: Bool?
  let signingPublicKey: String?
  let publicKey: NSPublicKey?
  let userPreference: NSUserPreference?
  
  enum CodingKeys: String, CodingKey {
    case username
    case isDevelop = "is_develop"
    case signingPublicKey = "signing_public_key"
    case publicKey = "public_key"
    case userPreference = "user_preference"
  }
}
