//
//  NS.swift
//  NineSunsSDK
//
//

public struct NSAccountInfo: Codable {
  var auth: NSAccountAuth
  var encryptedClientData: String
  var passwordDerivedSecret: String
}
