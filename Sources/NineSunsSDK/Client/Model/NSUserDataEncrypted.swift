//
//  NSUserDataEncrypted.swift
//  NineSunsSDK
//
//

public struct NSUserDataEncrypted: Codable {
  public let firstName: String?
  public let middleName: String?
  public let lastName: String?
  public let preferredFirstName: String?
  public let image: String?
  public let phoneNumber: String?
  public let email: String?
  public let encryptedClientData: String?
  public let totpSecret: String?
  
  enum CodingKeys: String, CodingKey {
    case firstName = "first_name"
    case middleName = "middle_name"
    case lastName = "last_name"
    case preferredFirstName = "preferred_first_name"
    case image
    case phoneNumber = "phone_number"
    case email
    case encryptedClientData = "encrypted_client_data"
    case totpSecret = "totp_secret"
  }
}
