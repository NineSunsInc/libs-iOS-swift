//
//  NSUserPrivateDataEncrypted.swift
//  NineSunsSDK
//
//

public struct NSUserPrivateDataEncrypted: Codable {
  public let encryptedUserData: String?
  
  enum CodingKeys: String, CodingKey {
    case encryptedUserData = "encrypted_user_data"
  }
}
