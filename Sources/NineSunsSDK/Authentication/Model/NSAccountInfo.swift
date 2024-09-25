//
//  NS.swift
//  NineSunsSDK
//
//

public struct NSAccountInfo: Codable {
  public var auth: NSAccountAuth
  public let userDataEncrypted: NSUserDataEncrypted?
  public let userPrivateDataEncrypted: NSUserPrivateDataEncrypted?
  public let userNonEncrypted: NSUserNonEncrypted?
  public let userPrivateDocumentData: NSUserPrivateDocumentData?
  public let encryptedClientData: String?
}
