//
//  NSLogin.swift
//  NineSunsSDK
//
//

import Foundation

public struct NSAuthentication {
  
  /**
   * Sign in to the NineSuns system using a user account.
   * @param {string} userName - The user's username.
   * @param {string} password - The user's password.
   * @returns {{accountInfo: NSAccountInfo, pds: string}} -
   * accountInfo: The user's account information.
   * pds: Password Derived Secret (PDS) - This is a secret key used for encryption and decryption. It should not be exposed to the internet.
   */
  public static func signIn(userName: String, password: String) async throws -> (accountInfo: NSAccountInfo, pds: String) {
    let (privateKeyStr, publicKeyStr) = SRPClient.generateEphemeral()
    let result = try await NSClient.signInRetrieve(username: userName, clientEphemeralPublic: publicKeyStr)
    guard let result = result else {
      throw NSError(domain: "Fail to sign in retrieve", code: 4, userInfo: nil)
    }
    guard let hashedPassword = SRPClient.hashPasswordWasm(password: password, salt: result.salt) else {
      throw NSError(domain: "Fail to hash password", code: 4, userInfo: nil)
    }
    guard let masterSecret = SRPClient.createKeyFromSecret(secret: hashedPassword, salt: result.salt) else {
      throw NSError(domain: "Fail to create key from secret", code: 4, userInfo: nil)
    }
    let privateKey = HKDFClient.createSRPKey(masterSecret: masterSecret, salt: result.salt)
    let serverEphemeralPublic = result.serverEphemeralPublic
    let salt = result.salt
    let session = try SRPClient.deriveSession(
      clientSecretEphemeral: privateKeyStr,
      serverPublicEphemeral: serverEphemeralPublic,
      salt: salt,
      username: userName,
      privateKey: privateKey
    )
    guard let resultProof = try await NSClient.signInProof(username: userName, proof: session.proof, ephemeralPublic: serverEphemeralPublic) else {
      throw NSError(domain: "Fail to get authenticate token", code: 4, userInfo: nil)
    }
    let authenticateToken = resultProof.data.authenticateToken
    let passwordDerivedSecret = HKDFClient.createPasswordDerivedSecret(
      masterSecret: masterSecret,
      salt: result.salt
    )
    guard let accountAuth = try await NSClient.signIn(username: userName, authenticateToken: authenticateToken) else {
      throw NSError(domain: "Fail to sign in", code: 4, userInfo: nil)
    }
    let accountInfo = NSAccountInfo(
      auth: accountAuth,
      userDataEncrypted: resultProof.data.userDataEncrypted,
      userPrivateDataEncrypted: resultProof.data.userPrivateDataEncrypted,
      userNonEncrypted: resultProof.data.userNonEncrypted,
      userPrivateDocumentData: resultProof.data.userPrivateDocumentData,
      encryptedClientData: resultProof.data.encryptedClientData
    )
    return (accountInfo: accountInfo, pds: passwordDerivedSecret)
  }
  
  /**
   * Get new access token using the refresh token.
   * @param {string} refreshToken - The refresh token.
   * @returns The token response with access token and refresh token infor
   */
  public static func newAccessToken(with refreshToken: String) async throws -> NSAccountAuth? {
    try await NSClient.newAccessToken(with: refreshToken)
  }
}
