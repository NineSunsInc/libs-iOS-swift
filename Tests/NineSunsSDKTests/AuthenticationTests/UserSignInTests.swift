//
//  UserSignInTests.swift
//  NineSunsSDK
//
//

import Testing
@testable import NineSunsSDK

@Test func signInSuccessfulTests() async throws {
  let userName = "luantran"
  let password = "jaDbuk-nymby5-r7!fOR"
  
  do {
    print("START TESTING SIGN IN SDK:")
    print("User Name: \(userName)")
    print("Password: *********")
    let response = try await NSAuthentication.signIn(userName: userName, password: password)
    print("Access Token: \(response.accountInfo.auth.accessToken)")
    print("Refresh Token: \(response.accountInfo.auth.refreshToken)")
    #expect(Bool(true), "Sign In success")
  } catch {
    #expect(Bool(false), "Sign In fail")
  }
}
