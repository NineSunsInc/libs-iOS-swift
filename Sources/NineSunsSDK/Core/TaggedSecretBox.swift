//
//  TaggedSecretBox.swift
//  NineSunsSDK
//
//

import Foundation
import CryptoKit

let NONCE_LENGTH = 12

class TaggedSecretBox {
  private var key: SymmetricKey
  
  init(keyBytes: Data) {
    self.key = SymmetricKey(data: keyBytes)
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
