//
//  SigninProveResponseData.swift
//  NineSunsSDK
//
//

struct SignInProveResponseData: Codable {
  var authenticateToken: String
  var encryptedClientData: String
  
  enum CodingKeys: String, CodingKey {
    case authenticateToken = "authenticate_token"
    case encryptedClientData = "encrypted_client_data"
  }
}

struct SignInProveResponse: Codable {
  var data: SignInProveResponseData
}
