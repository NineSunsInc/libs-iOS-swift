//
//  NSAccountAuth.swift
//  NineSunsSDK
//
//

public struct NSAccountAuth: Codable {
  public var username: String
  public var roles: [String]
  public var accessToken: String
  public var refreshToken: String
  public var expiresIn: Double?
  
  enum CodingKeys: String, CodingKey {
    case username
    case roles
    case accessToken = "access_token"
    case refreshToken = "refresh_token"
    case expiresIn = "expires_in"
  }
}
