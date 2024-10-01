//
//  NSClient.swift
//  NineSunsSDK
//
//

import Foundation

struct NSClient {
  static func request(endPoint: String, method: NSHTTPMethod = .GET, environment: NSEnvironment = .dev, bodyData: [String: Any]? = nil) async throws -> Data {
    guard let url = URL(string: environment.baseUrl + endPoint) else {
      throw NSError(domain: "Invalid endpoint", code: 4, userInfo: nil)
    }
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    if let bodyData = bodyData {
      request.httpBody = try JSONSerialization.data(withJSONObject: bodyData, options: [])
    }
    let (data, _) = try await URLSession.shared.data(for: request)
    return data
  }
}

extension NSClient {
  static func signInRetrieve(username: String, clientEphemeralPublic: String) async throws -> SigninRetrieveResponse? {
    let requestBody: [String: Any] = [
      "username": username,
      "client_ephemeral_public": clientEphemeralPublic
    ]
    let data = try await NSClient.request(
      endPoint: "api/users/signin-retrieve",
      method: .POST,
      bodyData: requestBody
    )
    let response = JSONHelper.decodeJSONData(SigninRetrieveResponse.self, from: data)
    return response
  }
  
  static func signInProof(username: String, proof: String, ephemeralPublic: String) async throws -> SignInProveResponse? {
    let requestBody: [String: Any] = [
      "username": username,
      "client_session_proof": proof,
      "client_ephemeral_public": ephemeralPublic
    ]
    let data = try await NSClient.request(
      endPoint: "api/users/signin-prove",
      method: .POST,
      bodyData: requestBody
    )
    let response = JSONHelper.decodeJSONData(SignInProveResponse.self, from: data)
    return response
  }
  
  static func signIn(username: String, authenticateToken: String) async throws -> NSAccountAuth? {
    let parameters = [
      "username": username,
      "authenticate_token": authenticateToken
    ]
    let data = try await NSClient.request(
      endPoint: "login/credentials",
      method: .POST,
      bodyData: parameters
    )
    let response = JSONHelper.decodeJSONData(NSAccountAuth.self, from: data)
    return response
  }
  
  static func newAccessToken(with refreshToken: String) async throws -> NSTokenResponse? {
    let parameters = [
      "grant_type": "refresh_token",
      "refresh_token": refreshToken
    ]
    let data = try await NSClient.request(
      endPoint: "oauth/access-token",
      method: .POST,
      bodyData: parameters
    )
    let response = JSONHelper.decodeJSONData(NSTokenResponse.self, from: data)
    return response
  }
}
