//
//  NSAccountAuth.swift
//  NineSunsSDK
//
//

public struct NSAccountAuth: Codable {
  var username: String
  var roles: [String]
  var accessToken: String
  var refreshToken: String
  var expiresIn: Double?
  
  enum CodingKeys: String, CodingKey {
    case username
    case roles
    case accessToken = "access_token"
    case refreshToken = "refresh_token"
    case expiresIn = "expires_in"
  }
}
