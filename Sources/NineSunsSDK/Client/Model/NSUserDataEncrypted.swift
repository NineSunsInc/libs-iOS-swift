//
//  NSUserDataEncrypted.swift
//  NineSunsSDK
//
//

struct NSUserDataEncrypted: Codable {
  let firstName: String?
  let middleName: String?
  let lastName: String?
  let preferredFirstName: String?
  let image: String?
  let phoneNumber: String?
  let email: String?
  let encryptedClientData: String?
  
  enum CodingKeys: String, CodingKey {
    case firstName = "first_name"
    case middleName = "middle_name"
    case lastName = "last_name"
    case preferredFirstName = "preferred_first_name"
    case image
    case phoneNumber = "phone_number"
    case email
    case encryptedClientData = "encrypted_client_data"
  }
}
