//
//  HKDFInfo.swift
//  NineSunsSDK
//
//

import Foundation

enum HKDFInfo: String {
  case login = "LOGIN"
  case privateKeys = "PRIVATE_KEYS"
}

extension HKDFInfo {
  var data: Data {
    Data(rawValue.utf8)
  }
}

