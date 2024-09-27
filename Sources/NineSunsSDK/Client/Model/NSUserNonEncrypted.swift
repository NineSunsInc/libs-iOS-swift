//
//  NSUserNonEncrypted.swift
//  NineSunsSDK
//
//

public struct NSUserNonEncrypted: Codable {
  public let username: String?
  public let isDevelop: Bool?
  public let signingPublicKey: String?
  public let publicKey: NSPublicKey?
  public let userPreference: NSUserPreference?
  
  enum CodingKeys: String, CodingKey {
    case username
    case isDevelop = "is_develop"
    case signingPublicKey = "signing_public_key"
    case publicKey = "public_key"
    case userPreference = "user_preference"
  }
}
