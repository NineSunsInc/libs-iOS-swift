//
//  SymmetricDecryption.swift
//  NineSunsSDK
//
//

import Foundation
import TweetNacl

public extension NineSunsSDK {
  
  static func decryptSymmetric(message: String, symmetricKey: String, datagram: JSONDatagram) throws -> String? {
    guard let keyData = decodeBase64Message(symmetricKey) else {
      throw NSError(domain: "SymmetricEncryption", code: 4, userInfo: [NSLocalizedDescriptionKey: "Couldn't get data of symmetric key: \(symmetricKey)"])
    }
    guard let messageData = decodeBase64Message(message) else {
      throw NSError(domain: "SymmetricEncryption", code: 4, userInfo: [NSLocalizedDescriptionKey: "Couldn't get data of message: \(message)"])
    }
    let box = TaggedSecretBox(keyBytes: keyData)
    return try box.decrypt(datagram: datagram, bytes: messageData)
  }
  
}
