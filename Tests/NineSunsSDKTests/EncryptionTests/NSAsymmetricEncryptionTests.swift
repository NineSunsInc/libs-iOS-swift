//
//  NSAsymmetricEncryptionTests.swift
//  NineSunsSDK
//
//

import Testing
@testable import NineSunsSDK

let privateKey = "m0m6L4s9blikJ/Ds9c3KVA/Qkqf4jQEoSYLHUo4j3LQ="
let publicKey = "oaijysb01+sHQ3ao0kc3tF2Wcy9/M7M3a2S7crkBzm4="

@Test func asymmetricEncryptionSingleTests() async throws {
  let message = "Hello, World!"
  guard let encrypted = NSEncryption.stringEncryptAsymmetric(
    privateKey: privateKey, publicKey: publicKey, message: message) else {
    #expect(Bool(false))
    return
  }
  guard let decryptedMessage = try? NSDecryption.stringDecryptAsymmetric(
    privateKey: privateKey,
    publicKey: publicKey,
    encryptedText: encrypted
  ) else {
    #expect(Bool(false))
    return
  }
  
  #expect(message == decryptedMessage)
}

@Test func asymmetricEncryptionTests() async throws {
  let messages = [
    "Hello, World!",
    "Makers & Restorers of Traditional Wooden Rocking Horses. Every horse",
    "412312562123594386747316-=_+_-=[]{}|;':<>?><<"
  ]
  print("----- STARTING TESTING ASYMMETRIC ENCRYPTION -----")
  print("Private Key: \(privateKey)")
  print("Public Key: \(publicKey)")
  print("-----")
  var index = 0
  for message in messages {
    defer {
      index += 1
    }
    print("--- CASE \(index):")
    print("Message: \(message)")
    guard let encrypted = NSEncryption.stringEncryptAsymmetric(
      privateKey: privateKey, publicKey: publicKey, message: message) else {
      #expect(Bool(false))
      return
    }
    print("Encrypted: \(encrypted)")
    guard let decryptedMessage = try? NSDecryption.stringDecryptAsymmetric(
      privateKey: privateKey,
      publicKey: publicKey,
      encryptedText: encrypted
    ) else {
      #expect(Bool(false))
      return
    }
    print("Decrypted back: \(decryptedMessage)")
    #expect(message == decryptedMessage)
  }
}
