//
//  NSCatCryptoTests.swift
//  NineSunsSDK
//
//

import Testing
@testable import NSCatCrypto

@Test func hashPasswordArgon2id() async throws {
  let password = "4ur55-j3r3my-TIjh"
  let salt = "8d9c1aff1d40bd4d4622b1e107009ae166465766ceaa429ce0dcf64109e27ecd"
  let hashedExpectation = "$argon2id$v=19$m=1000,t=256,p=4$OGQ5YzFhZmYxZDQwYmQ0ZDQ2MjJiMWUxMDcwMDlhZTE2NjQ2NTc2NmNlYWE0MjljZTBkY2Y2NDEwOWUyN2VjZA$nBh2OcB4cAWVO+8gjMGmonRG5CNHFbYzfLdOxBzKS1E"
  
  print("----- STARTING TESTING ARGON2ID -----")
  print("Password: \(password)")
  print("Salt: \(salt)")
  print("-----")
  
  let content = CatArgon2Crypto.Context()
  content.salt = salt
  content.iterations = 256
  content.parallelism = 4
  content.memory = 1000
  content.hashLength = 32
  content.mode = .argon2id
  content.hashResultType = .hashEncoded
  let hash = CatArgon2Crypto(context: content)
  let result = hash.hash(password: password)
  let hashedPassword = result.stringValue()
  
  print("HashedPassword: \(hashedPassword)")
  #expect(hashedPassword == hashedExpectation)
}
