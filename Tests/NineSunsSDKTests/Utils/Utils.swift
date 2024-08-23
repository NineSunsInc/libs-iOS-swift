//
//  Utils.swift
//  ninesunsencrypted
//
//

import Foundation

// Function to read JSON file
func readJSONFile(filename: String) -> Data? {
  let fileURL = Bundle.main.url(forResource: filename, withExtension: "json")
  guard let url = fileURL else {
    print("File not found: \(filename).json")
    return nil
  }
  
  do {
    let data = try Data(contentsOf: url)
    return data
  } catch {
    print("Error reading file: \(error)")
    return nil
  }
}

// Function to decode JSON data
func decodeJSONData<T: Codable>(_ type: T.Type, from data: Data) -> T? {
  let decoder = JSONDecoder()
  do {
    let decodedObject = try decoder.decode(T.self, from: data)
    return decodedObject
  } catch {
    print("Error decoding JSON: \(error)")
    return nil
  }
}

func getTestData() -> [DataModel] {
  guard let jsonData = readJSONFile(filename: "testdata") else {
    return []
  }
  return decodeJSONData([DataModel].self, from: jsonData) ?? []
}
