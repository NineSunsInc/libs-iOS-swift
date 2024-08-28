//
//  NSEncryption.swift
//  NineSunsSDK
//
//
import Foundation

public struct NSEncryption {
  
  /**
   * Symmetric encryption method for string.
   * - Parameters:
   *   - message: Data to encrypt in String.
   *   - symmetricKey: symmetric key.
   *   - datagram: Datagram to encrypt.
   * - Returns: Encrypted plaintext.
   */
  public static func encryptSymmetric(message: String, symmetricKey: String, datagram: JSONDatagram) throws -> String? {
    guard let keyData = decodeBase64Message(symmetricKey) else {
      throw NSError(domain: "SymmetricEncryption", code: 4, userInfo: [NSLocalizedDescriptionKey: "Couldn't get data of symmetric key: \(symmetricKey)"])
    }
    let box = TaggedSecretBox(keyBytes: keyData)
    return try box.encrypt(datagram: datagram, data: message)
  }
  
}
