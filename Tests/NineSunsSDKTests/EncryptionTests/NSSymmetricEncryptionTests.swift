//
//  NSSymmetricEncryptionTests.swift
//  NineSunsSDK
//
//

import Testing
@testable import NineSunsSDK

@Test func symmetricEncryptionSingleTests() async throws {
  let message = "Ready to craft the ultimate welcome message that'll wow your customers?"
  let symmetricKey = "vBdLik0fmFIP9uSfRQgPk3yBQCTalmP4nwBwqaU/Pm0="
  let jsonDatagram = JSONDatagram(type: "User Shared Encrypted Data Datagram")
  guard let encrypted = try NSEncryption.encryptSymmetric(message: message, symmetricKey: symmetricKey, datagram: jsonDatagram) else {
    #expect(Bool(false))
    return
  }
  let decryptedAgain = try NSDecryption.decryptSymmetric(message: encrypted, symmetricKey: symmetricKey, datagram: jsonDatagram)
  
  #expect(decryptedAgain == message)
}

@Test func symmetricEncryptionNumberAndSymbolTests() async throws {
  let message = "1234567890,./<>?;';:[\"]}}{}+==_-)))0(*&^%$#@!``~?"
  let symmetricKey = "vBdLik0fmFIP9uSfRQgPk3yBQCTalmP4nwBwqaU/Pm0="
  let jsonDatagram = JSONDatagram(type: "User Shared Encrypted Data Datagram")
  guard let encrypted = try NSEncryption.encryptSymmetric(message: message, symmetricKey: symmetricKey, datagram: jsonDatagram) else {
    #expect(Bool(false))
    return
  }
  let decryptedAgain = try NSDecryption.decryptSymmetric(message: encrypted, symmetricKey: symmetricKey, datagram: jsonDatagram)
  
  #expect(decryptedAgain == message)
}

@Test func symmetricEncryptionTests() {
  let messages = [
    "The poems themselves cover a broad range of themes: glimpses of the poet's childhood and marriage, the ironies of love,",
    "1. a wooden toy horse that children can move backwards and forwards while they are sitting on it 2…. Learn more.",
    "\"The Rocking-Horse Winner\" is a short story by D. H. Lawrence. It was first published in July 1926, in Harper's Bazaar and subsequently appeared in the ...",
    "Makers & Restorers of Traditional Wooden Rocking Horses. Every horse is a hand crafted individual; ready-to-ride horses"
  ]
  let symmetricKey = "vBdLik0fmFIP9uSfRQgPk3yBQCTalmP4nwBwqaU/Pm0="
  let jsonDatagram = JSONDatagram(type: "User Shared Encrypted Data Datagram")
  
  print("----- STARTING TESTING SYMMETRIC ENCRYPTION -----")
  print("Symmetric Key: \(symmetricKey)")
  print("-----")
  
  var index = 0
  for message in messages {
    defer {
      index += 1
    }
    print("----- CASE \(index):")
    print("Starting encrypted message: \(message)")
    guard let encrypted = try? NSEncryption.encryptSymmetric(message: message, symmetricKey: symmetricKey, datagram: jsonDatagram) else {
      print("Encrypt fail")
      #expect(Bool(false))
      return
    }
    print("Encrypted: \(encrypted)")
    let decryptedAgain = try? NSDecryption.decryptSymmetric(message: encrypted, symmetricKey: symmetricKey, datagram: jsonDatagram)
    print("Decrypted back: \(decryptedAgain ?? "")")
    #expect(decryptedAgain == message)
  }
}
