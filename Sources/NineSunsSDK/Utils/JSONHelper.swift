//
//  JSONHelper.swift
//  NineSunsSDK
//
//

import Foundation

class JSONHelper {
  static func decodeJSONData<T: Codable>(_ type: T.Type, from data: Data) -> T? {
    let decoder = JSONDecoder()
    do {
      let decodedObject = try decoder.decode(T.self, from: data)
      return decodedObject
    } catch {
      print("JSONHelper error: \(error)")
      return nil
    }
  }
  
  static func decodeJSONString<T: Codable>(_ type: T.Type, from text: String) -> T? {
    guard let data = text.data(using: .utf8) else {
      return nil
    }
    return decodeJSONData(T.self, from: data)
  }
}

