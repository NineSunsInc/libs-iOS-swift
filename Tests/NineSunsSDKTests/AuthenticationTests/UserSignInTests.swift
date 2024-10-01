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

@Test func newAccessTokenTests() async throws {
  let refreshToken = "eyJhbGciOiJIUzI1NiJ9.ZWUxMGNiN2ItODgxOC00NDQ1LTk2YjktMzA0M2E0Zjk5MWFl.qHqMRWobTj-t7JHD79nN4jcrZow3xqGWfIhf-ldPaYw"
  do {
    print("START TESTING GET NEW ACCESS TOKEN")
    let response = try await NSAuthentication.newAccessToken(with: refreshToken)
    #expect(response != nil)
    print("Access Token: \(response!.accessToken)")
    print("Refresh Token: \(response!.refreshToken)")
  } catch (let error) {
    print("Get new access token fail: \(error)")
    #expect(Bool(false), "Get new access token fail")
  }
}
