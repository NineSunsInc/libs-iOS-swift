//
//  JSONDatagram.swift
//  NineSunsSDK
//
//

import Foundation

public class JSONDatagram {
  var type: String
  var version: String
  var versionConstraint: String
  
  init(type: String, version: String = "0.0.1", versionConstraint: String = "0.0.*") {
    self.type = type
    self.version = version
    self.versionConstraint = versionConstraint
  }
  
  func serialize(data: [String: Any]) -> Data? {
    var jsonData: Data?
    let dict: [String: Any] = ["version": self.version, "type": self.type, "data": data]
    do {
      jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
    } catch {
      print("Error serializing JSON: \(error)")
    }
    return jsonData
  }
  
  func deserialize(data: Data) -> String? {
    do {
      guard
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
        let dataObject = jsonObject["data"] as? [String: Any]
      else {
        return nil
      }
      let data = try JSONSerialization.data(withJSONObject: dataObject, options: .prettyPrinted)
      return String(data: data, encoding: .utf8)
    } catch {
      print("Error deserializing JSON: \(error)")
    }
    return nil
  }
}
