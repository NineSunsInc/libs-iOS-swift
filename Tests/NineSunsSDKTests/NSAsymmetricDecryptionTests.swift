import Testing
@testable import NineSunsSDK

@Test func stringDecryptAsymmetric() async throws {
  let testData = getTestData()
  #expect(!testData.isEmpty)
  for data in testData {
    let result = try? NSDecryption.stringDecryptAsymmetric(
      myPrivateKey: data.privateKey,
      theirPublicKey: data.publicKey,
      encryptedText: data.encryptedData
    )
    #expect(result == data.rawData)
  }
}
