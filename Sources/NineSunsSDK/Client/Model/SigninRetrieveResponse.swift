//
//  SigninRetrieveResponse.swift
//  NineSunsSDK
//
//

struct SigninRetrieveResponse: Codable {
  var salt: String
  var serverEphemeralPublic: String
  
  enum CodingKeys: String, CodingKey {
    case salt
    case serverEphemeralPublic = "server_ephemeral_public"
  }
}
