//
//  NSUserPrivateDocumentData.swift
//  NineSunsSDK
//
//

public struct NSUserPrivateDocumentData: Codable {
  public let privateDocumentData: String
  
  enum CodingKeys: String, CodingKey {
    case privateDocumentData = "private_document_data"
  }
}
