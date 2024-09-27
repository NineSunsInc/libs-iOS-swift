//
//  NSUserPreference.swift
//  NineSunsSDK
//
//

public struct NSUserPreference: Codable {
  public let id: String
  public let userId: String
  public let dateFormat: String
  public let language: String
  public let timezone: String?
  public let theme: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case userId = "user_id"
    case dateFormat = "date_format"
    case language
    case timezone
    case theme
  }
}
