//
//  NSUserPreference.swift
//  NineSunsSDK
//
//

public struct NSUserPreference: Codable {
  let id: String
  let userId: String
  let dateFormat: String
  let language: String
  let timezone: String?
  let theme: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case userId = "user_id"
    case dateFormat = "date_format"
    case language
    case timezone
    case theme
  }
}
