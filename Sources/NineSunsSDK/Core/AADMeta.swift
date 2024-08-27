//
//  AADMeta.swift
//  NineSunsSDK
//
//

import Foundation

let METADATA_VERSION = "0.1.0"

class AADMeta {
  var version: String
  var type: String
  var nonce: Data
  
  init(version: String, type: String, nonce: Data) {
    self.version = version
    self.type = type
    self.nonce = nonce
  }
  
  func serialize() -> Data? {
    let metadataVersionData = varintPrefixed(utf8StringToBytes(METADATA_VERSION))
    let versionData = varintPrefixed(utf8StringToBytes(version))
    let typeData = varintPrefixed(utf8StringToBytes(type))
    let nonceData = varintPrefixed(nonce)
    
    let data = concatUint8Arrays(metadataVersionData, versionData, typeData, nonceData)
    return varintPrefixed(data)
  }
  
  static func deserialize(data: Data) throws -> (metadata: AADMeta, rawMetadata: Data, content: Data) {
    var dataDict: [String: Data] = ["bs": data]
    let header = extractVarintPrefixed(&dataDict)
    
    let rawMetadata = varintPrefixed(header)
    let content = data.subdata(in: rawMetadata.count..<data.count)
    
    var headerBuf = ["bs": header]
    let metadataVersion = utf8BytesToString(extractVarintPrefixed(&headerBuf))
    if metadataVersion != METADATA_VERSION {
      throw NSError(domain: "AADMeta", code: 1, userInfo: [NSLocalizedDescriptionKey: "Unrecognized metadata version"])
    }
    
    let version = utf8BytesToString(extractVarintPrefixed(&headerBuf))
    let type = utf8BytesToString(extractVarintPrefixed(&headerBuf))
    let nonce = extractVarintPrefixed(&headerBuf)
    
    if !(headerBuf["bs"]?.isEmpty ?? true) {
      throw NSError(domain: "AADMeta", code: 2, userInfo: [NSLocalizedDescriptionKey: "Unexpected additional content in header"])
    }
    
    let metadata = AADMeta(version: version, type: type, nonce: nonce)
    return (metadata, rawMetadata, content)
  }
}
