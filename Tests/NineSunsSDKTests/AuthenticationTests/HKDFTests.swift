//
//  Tests.swift
//  NineSunsSDK
//
//

import Testing
@testable import NineSunsSDK

@Test func createPasswordDeliverSecretTests() async throws {
  let masterSecret = "fQixWKitNA+4IHJqa9SQC0xHgZSBdoDfc2GDjSf1p78="
  let salt = "8d9c1aff1d40bd4d4622b1e107009ae166465766ceaa429ce0dcf64109e27ecd"
  let pds = HKDFClient.createPasswordDerivedSecret(masterSecret: masterSecret, salt: salt)
  
  let expectedPDS = "GrhsbHTzMlEZDg8H05qKGrQsYJ3YF+r9c1vjt1c/GaU="
  #expect(pds == expectedPDS)
}

@Test func createSRPKeyTests() async throws {
  let masterSecret = "fQixWKitNA+4IHJqa9SQC0xHgZSBdoDfc2GDjSf1p78="
  let salt = "8d9c1aff1d40bd4d4622b1e107009ae166465766ceaa429ce0dcf64109e27ecd"
  let expectedPrivateKey = "ea2d237638addc1a0b4190b7a0039724116d597bb1c67e70a58c9c3c9ce0f95b"
  
  let privateKey = HKDFClient.createSRPKey(masterSecret: masterSecret, salt: salt)
  
  #expect(privateKey == expectedPrivateKey)
}
