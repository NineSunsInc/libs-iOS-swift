// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import TweetNacl

public struct NSDecryption {
  
  private static let nonceLength = 24
  
  private static func decryptAsymmetric(secretOrSharedKey: Data, messageWithNonce: String, key: Data? = nil) throws -> String {
    guard let messageWithNonceData = Data(base64Encoded: messageWithNonce) else {
      throw NSError(domain: "Invalid base64 string", code: -1, userInfo: nil)
    }
    
    // Extract the nonce and message
    let nonce = messageWithNonceData.subdata(in: 0..<NSDecryption.nonceLength)
    let message = messageWithNonceData.subdata(in: NSDecryption.nonceLength..<messageWithNonceData.count)
    
    // Decrypt the message
    let decrypted: Data
    if let key = key {
      decrypted = try NaclBox.open(message: message, nonce: nonce, publicKey: key, secretKey: secretOrSharedKey)
    } else {
      decrypted = try NaclSecretBox.open(box: message, nonce: nonce, key: secretOrSharedKey)
    }
    
    // Convert decrypted Data to string
    guard let decryptedMessage = String(data: decrypted, encoding: .utf8) else {
      throw NSError(domain: "Could not convert decrypted data to string", code: -1, userInfo: nil)
    }
    
    return decryptedMessage
  }
  
  /**
   * Asymmetric decryption method for string.
   * - Parameters:
   *   - myPrivateKey: User's private encryption key.
   *   - theirPublicKey: Recipient's public key.
   *   - encryptedText: Data to decrypt.
   * - Returns: Decrypted plaintext.
   */
  public static func stringDecryptAsymmetric(myPrivateKey: String, theirPublicKey: String, encryptedText: String) throws -> String {
    // Convert keys from base64 to Data
    guard let myPrivateKeyData = Data(base64Encoded: myPrivateKey),
          let theirPublicKeyData = Data(base64Encoded: theirPublicKey) else {
      throw NSError(domain: "Invalid base64 string for keys", code: -1, userInfo: nil)
    }
    
    // Generate the shared key using the before method
    let sharedKey = try NaclBox.before(publicKey: theirPublicKeyData, secretKey: myPrivateKeyData)
    
    // Decrypt the encrypted text
    let decrypted = try decryptAsymmetric(secretOrSharedKey: sharedKey, messageWithNonce: encryptedText)
    
    return decrypted
  }
  
  /**
   * Symmetric decryption method for string.
   * - Parameters:
   *   - message: Data to decrypt in String.
   *   - symmetricKey: symmetric key.
   *   - datagram: Datagram to decrypt.
   * - Returns: Decrypted plaintext.
   */
  public static func decryptSymmetric(message: String, symmetricKey: String, datagram: JSONDatagram) throws -> String? {
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
