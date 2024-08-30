//
//  NSEncryption.swift
//  NineSunsSDK
//
//
import Foundation
import CryptoKit
import TweetNacl

public struct NSEncryption {
  
  /**
   * Asymmetric encryption method for string.
   * - Parameters:
   *   - secretOrSharedKey: Data of a shared secret key between your private key and the recipient's public key
   *   - message: Plaint text to encrypt.
   * - Returns: Encrypted plaintext.
   */
  private static func encryptAsymmetric(secretOrSharedKey: Data, message: String) -> String? {
    // Convert message to Data
    guard let messageData = message.data(using: .utf8) else {
      print("Failed to convert message to Data")
      return nil
    }
    
    // Generate a nonce
    let nonceData = Data((0..<NACL_NONCE_LENGTH).map { _ in UInt8.random(in: 0...255) })
    
    do {
      let encryptedMessage = try NaclSecretBox.secretBox(message: messageData, nonce: nonceData, key: secretOrSharedKey)
      
      // Concatenate nonce and encrypted message
      let fullMessage = nonceData + encryptedMessage
      
      // Encode the result as base64
      let encodedMessage = fullMessage.base64EncodedString()
      
      return encodedMessage
    } catch {
      print("Encryption failed: \(error)")
      return nil
    }
  }
  
  /**
   * Asymmetric encryption method for string.
   * - Parameters:
   *   - privateKey: User's private encryption key.
   *   - publicKey: Recipient's public key.
   *   - encryptedText: Data to encrypt.
   * - Returns: Encrypted plaintext.
   */
  public static func stringEncryptAsymmetric(privateKey: String, publicKey: String, message: String) -> String? {
    do {
      guard let privateKeyData = Data(base64Encoded: privateKey),
            let publicKeyData = Data(base64Encoded: publicKey) else {
        throw NSError(domain: "Invalid base64 string for keys", code: -1, userInfo: nil)
      }
      
      // Generate the shared key using the before method
      let sharedKey = try NaclBox.before(publicKey: publicKeyData, secretKey: privateKeyData)
      
      // Encrypt the message
      return encryptAsymmetric(secretOrSharedKey: sharedKey, message: message)
    } catch {
      print("Error: \(error)")
      return nil
    }
  }
  
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
