//
//  SigninProveResponseData.swift
//  NineSunsSDK
//
//

struct SignInProveResponseData: Codable {
  let serverSessionProof: String
  let authenticateToken: String
  
  let userDataEncrypted: NSUserDataEncrypted?
  let userPrivateDataEncrypted: NSUserPrivateDataEncrypted?
  let userNonEncrypted: NSUserNonEncrypted?
  let userPrivateDocumentData: NSUserPrivateDocumentData?
  let encryptedClientData: String?
  
  enum CodingKeys: String, CodingKey {
    case serverSessionProof = "server_session_proof"
    case userDataEncrypted = "user_data_encrypted"
    case userPrivateDataEncrypted = "user_private_data_encrypted"
    case userNonEncrypted = "user_non_encrypted"
    case userPrivateDocumentData = "user_private_document_data"
    case encryptedClientData = "encrypted_client_data"
    case authenticateToken = "authenticate_token"
  }
}

struct SignInProveResponse: Codable {
  var data: SignInProveResponseData
}
