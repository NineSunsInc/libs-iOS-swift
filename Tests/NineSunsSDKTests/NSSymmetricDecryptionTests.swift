//
//  NSSymmetricDecryptionTests.swift
//  NineSunsSDK
//
//


import Testing
@testable import NineSunsSDK

@Test func symmetricDecryptionTests() async throws {
  let message = "PQUwLjEuMAUwLjAuMSNVc2VyIFNoYXJlZCBFbmNyeXB0ZWQgRGF0YSBEYXRhZ3JhbQxuahthwvVm4r+Vhxy8vsARHeUcvNG2MU9l+yomjYYigTvzjYbmUJlprpsRD5ArXeJ0KlsQIgg6mSarv0jBjRz4ckZEgcDKrOMe42DqzKvwfPbzbe6h1Kqj19oYRT3v85XkhT+9bAbVSDwdXH7kJagjTm4JfQQNxCnFQ5wenp7aIFcHx7XcTY8HIwlpL+D/tPS3ggutI1qMFCa2r2CB7w1lmnPIvy17qdgFWqjRFQ=="
  let symmetricKey = "vBdLik0fmFIP9uSfRQgPk3yBQCTalmP4nwBwqaU/Pm0="
  let jsonDatagram = JSONDatagram(type: "User Shared Encrypted Data Datagram")
  let result = try NSDecryption.decryptSymmetric(message: message, symmetricKey: symmetricKey, datagram: jsonDatagram)
  
  #expect(result == "Ready to craft the ultimate welcome message that'll wow your customers?")
}

@Test func symmetricDecryptionTests2() async throws {
  let message = "PQUwLjEuMAUwLjAuMSNVc2VyIFNoYXJlZCBFbmNyeXB0ZWQgRGF0YSBEYXRhZ3JhbQy+XKTRQbuFWrsqD8lKiA9clWnQsCPYtbTSMh9jGbqYhdAeEHNXNX+gdno69PrHf9k4ZCjEJ9LhF4An3oORfGU3vNK9S8nzyivXiyTy4dVBs/oVmVTiJctFYj3m6C2QBcYXqmEXlQ3XOvgC3HMT6XOlEnf0Tp32ZmFWHREod8QwZCktyHvIToQhpByAQurJes7JZ3SLw+UtGG6R0VPErCNYtbJjFN1dCA/YB7/mwEzwvD3bd576BXugMKiwb7Ddk1jUtSnZVqKRCJX62z7nFOwV44mTXf6J0bY="
  let symmetricKey = "vBdLik0fmFIP9uSfRQgPk3yBQCTalmP4nwBwqaU/Pm0="
  let jsonDatagram = JSONDatagram(type: "User Shared Encrypted Data Datagram")
  let result = try NSDecryption.decryptSymmetric(message: message, symmetricKey: symmetricKey, datagram: jsonDatagram)
  
  #expect(result == "Turn to some of the greatest thinkers of the past with these 19 quotes to help you get motivated to learn English.")
}

@Test func symmetricDecryptionTestsNumberAndSymbol() async throws {
  let message = "PQUwLjEuMAUwLjAuMSNVc2VyIFNoYXJlZCBFbmNyeXB0ZWQgRGF0YSBEYXRhZ3JhbQxUNI5SH6jY0kStarlULB4kOn/YBPDPjkvVwlqkpjE7UobmGUmQTfP66xLzmllFDIiwNIOH0P6hExvDaxyjAPsmjIG6z+CGf/vooIpfyqZvfEp1q1nLums4Rm7/Uh9ekF9zdrv0BDPcZPSY6EJ8iVR4BSUbcWshFUqTbSCjwxZ0XVHTmOjWAixxuk5yGbPnT4oGnkbM9QjxZw9lb40yMg6YkR/RRXyrHAFs0EysHwqZPaQ="
  let symmetricKey = "vBdLik0fmFIP9uSfRQgPk3yBQCTalmP4nwBwqaU/Pm0="
  let jsonDatagram = JSONDatagram(type: "User Shared Encrypted Data Datagram")
  let result = try NSDecryption.decryptSymmetric(message: message, symmetricKey: symmetricKey, datagram: jsonDatagram)
  
  #expect(result == "4y4td6788j29001827366452782901019;1234098756,./<>?:}{[]!@#$$#%%#%#^^&&*()~`")
}
