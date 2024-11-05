//
//  NSUtils.swift
//  NineSunsSDK
//
//

import Foundation
import CryptoKit

public struct NSUtils {
  public static func hashEmail(_ email: String) -> String? {
    guard let emailData = email.data(using: .utf8) else {
      print("Failed to convert email to Data.")
      return nil
    }
    let sha512Hash = SHA512.hash(data: emailData)
    let hashData = Data(sha512Hash)
    let base64HashString = hashData.base64EncodedString()
    
    guard let base64HashData = base64HashString.data(using: .utf8) else {
      print("Failed to convert Base64 hash string to Data.")
      return nil
    }
    let doubleBase64HashEmail = base64HashData.base64EncodedString()
    return doubleBase64HashEmail
  }
  
  public static func hashPhone(_ phone: String) -> String? {
    guard let phoneData = phone.data(using: .utf8) else {
      print("Failed to convert email to Data.")
      return nil
    }
    let sha512Hash = SHA512.hash(data: phoneData)
    let hashData = Data(sha512Hash)
    return hashData.base64EncodedString()
  }
}
