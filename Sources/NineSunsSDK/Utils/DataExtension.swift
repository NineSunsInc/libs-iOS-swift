//
//  DataExtension.swift
//  NineSunsSDK
//
//

import Foundation

extension Data {
  var hexString: String {
    let hexString = self.map { String(format: "%02x", $0) }.joined()
    return hexString
  }
}
