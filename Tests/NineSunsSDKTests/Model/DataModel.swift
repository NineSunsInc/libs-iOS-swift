//
//  DataModel.swift
//  ninesunsencrypted
//
//

import Foundation

struct DataModel: Codable {
  let rawData: String
  let publicKey: String
  let privateKey: String
  let encryptedData: String
}
