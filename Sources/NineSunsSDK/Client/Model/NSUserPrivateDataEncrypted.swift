//
//  NSUserPrivateDataEncrypted.swift
//  NineSunsSDK
//
//

struct NSUserPrivateDataEncrypted: Codable {
  let encryptedUserData: String?
  
  enum CodingKeys: String, CodingKey {
    case encryptedUserData = "encrypted_user_data"
  }
}
