//
//  NS.swift
//  NineSunsSDK
//
//

public struct NSAccountInfo: Codable {
  var auth: NSAccountAuth
  var passwordDerivedSecret: String
  let userDataEncrypted: NSUserDataEncrypted?
  let userPrivateDataEncrypted: NSUserPrivateDataEncrypted?
  let userNonEncrypted: NSUserNonEncrypted?
  let userPrivateDocumentData: NSUserPrivateDocumentData?
  let encryptedClientData: String?
}
