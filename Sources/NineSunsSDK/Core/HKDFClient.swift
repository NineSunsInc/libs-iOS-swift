//
//  HKDFClient.swift
//  NineSunsSDK
//
//

import Foundation
import CryptoKit

struct HKDFClient {
  
  static let HKDF_LENGTH = 32
  
  static func hkdfSha256(masterSecret: Data, salt: Data, info: Data, keyLength: Int) -> Data {
    let prk = HMAC<SHA256>.authenticationCode(for: masterSecret, using: SymmetricKey(data: salt))
    let prkData = Data(prk)
    
    var previousBlock = Data()
    var hkdfOutput = Data()
    var counter: UInt8 = 1
    
    while hkdfOutput.count < keyLength {
      var input = Data()
      input.append(previousBlock)
      input.append(info)
      input.append(counter)
      
      let nextBlock = HMAC<SHA256>.authenticationCode(for: input, using: SymmetricKey(data: prkData))
      
      previousBlock = Data(nextBlock)
      
      hkdfOutput.append(previousBlock)
      
      counter += 1
    }
    
    return hkdfOutput.prefix(keyLength)
  }
  
  static func createSRPKey(masterSecret: String, salt: String) -> String {
    let masterSecretData = Data(masterSecret.utf8)
    let saltData = Data(salt.utf8)
    let info = HKDFInfo.login.data
    
    let hkdfKey = HKDFClient.hkdfSha256(masterSecret: masterSecretData, salt: saltData, info: info, keyLength: HKDFClient.HKDF_LENGTH)
    
    let hkdfKeyHex = hkdfKey.hexString
    
    return hkdfKeyHex
  }
  
  /**
   * Generates the passwordDerivedSecret (a symmetric key that encrypts the user's private keys).
   * @param {string} masterSecret - User's master secret for HKDF input.
   * @param {string} salt - Salt to use in HKDF.
   * @returns {string} - Password derived secret.
   */
  static func createPasswordDerivedSecret(masterSecret: String, salt: String) -> String {
    let masterSecretData = Data(masterSecret.utf8)
    let saltData = Data(salt.utf8)
    let info = HKDFInfo.privateKeys.data
    
    let hkdfKey = hkdfSha256(masterSecret: masterSecretData, salt: saltData, info: info, keyLength: HKDF_LENGTH)
    
    return hkdfKey.base64EncodedString()
  }
  
}
