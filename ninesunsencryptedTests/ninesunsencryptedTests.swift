//
//  ninesunsencryptedTests.swift
//  ninesunsencryptedTests
//
//

import Testing
@testable import ninesunsencrypted

struct ninesunsencryptedTests {
  
  @Test func testDecryptAsymmetric() async throws {
    let testData = getTestData()
    for data in testData {
      let result = try? NineSunsSDK.stringDecryptAsymmetric(
        myPrivateKey: data.privateKey,
        theirPublicKey: data.publicKey,
        encryptedText: data.encryptedData
      )
      #expect(result == data.rawData)
    }
  }

}
