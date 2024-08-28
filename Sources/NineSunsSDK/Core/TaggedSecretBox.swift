//
//  TaggedSecretBox.swift
//  NineSunsSDK
//
//

import Foundation
import CryptoKit

class TaggedSecretBox {
  private var key: SymmetricKey
  
  init(keyBytes: Data) {
    self.key = SymmetricKey(data: keyBytes)
  }
  
  func encrypt(datagram: JSONDatagram, data: String) throws -> String? {
    let nonceData = Data((0..<12).map { _ in UInt8.random(in: 0...255) })
    
    let aad = AADMeta(version: datagram.version, type: datagram.type, nonce: nonceData)
    guard let aadSerialized = aad.serialize() else {
      throw NSError(domain: "TaggedSecretBox", code: 4, userInfo: [NSLocalizedDescriptionKey: "Couldn't encrypt: AADMeta cannot serialize"])
    }
    
    guard let plaintext = datagram.serialize(data: data) else {
      throw NSError(domain: "TaggedSecretBox", code: 4, userInfo: [NSLocalizedDescriptionKey: "Couldn't encrypt: JSONDatagram cannot serialize"])
    }
    
    let nonce = try ChaChaPoly.Nonce(data: nonceData)
    let sealedBox = try ChaChaPoly.seal(plaintext, using: self.key, nonce: nonce, authenticating: aadSerialized)
    if sealedBox.combined.count < NONCE_LENGTH {
      throw NSError(domain: "TaggedSecretBox", code: 4, userInfo: [NSLocalizedDescriptionKey: "Encrypted data coundn't less then NONCE_LENGTH"])
    }
    let encrypted = sealedBox.combined[NONCE_LENGTH...]
    
    let result = concatUint8Arrays(aadSerialized, encrypted)
    return result.base64EncodedString()
  }
  
  func decrypt(datagram: JSONDatagram, bytes: Data) throws -> String? {
    let header = try AADMeta.deserialize(data: bytes)
    let metadata = header.metadata
    
    let nonceData = metadata.nonce
    let ciphertext = header.content
    let rawMetadata = header.rawMetadata
    
    // Ensure the tag (rawMetadata) is at least 16 bytes long
    guard rawMetadata.count >= 16 else {
      fatalError("Invalid tag length: \(rawMetadata.count). Expected at least 16 bytes.")
    }
    
    // Extract the tag (last 16 bytes) and any additional data (if any)
    let tagIndex = ciphertext.count - 16
    let tag = ciphertext[tagIndex...]
    let remainCipertext = ciphertext[..<tagIndex]
    
    let nonce = try ChaChaPoly.Nonce(data: nonceData)
    let sealedBox = try ChaChaPoly.SealedBox(nonce: nonce, ciphertext: remainCipertext, tag: tag)
    let decryptedData = try ChaChaPoly.open(sealedBox, using: key, authenticating: rawMetadata)
    
    if datagram.type != metadata.type {
      throw NSError(domain: "TaggedSecretBox", code: 4, userInfo: [NSLocalizedDescriptionKey: "Couldn't decrypt: encrypted type (\(metadata.type)) doesn't match datagram type (\(datagram.type))"])
    }
    
    return datagram.deserialize(data: decryptedData)
  }
}
