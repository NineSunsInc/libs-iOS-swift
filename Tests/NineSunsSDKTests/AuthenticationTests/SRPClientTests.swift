//
//  SRPClientTests.swift
//  NineSunsSDK
//
//

import Testing
@testable import NineSunsSDK

@Test func hashPasswordWasmTests() async throws {
  let password = "jaDbuk-nymby5-r7!fOR"
  let salt = "8d9c1aff1d40bd4d4622b1e107009ae166465766ceaa429ce0dcf64109e27ecd"
  let expectedHash = "$argon2id$v=19$m=1000,t=256,p=4$OGQ5YzFhZmYxZDQwYmQ0ZDQ2MjJiMWUxMDcwMDlhZTE2NjQ2NTc2NmNlYWE0MjljZTBkY2Y2NDEwOWUyN2VjZA$2RlfBsO9/5y410QJwsksT8YDTuLqGqYqbo7BrQ8pmyI"
  let hashedPassword = SRPClient.hashPasswordWasm(password: password, salt: salt)
  #expect(hashedPassword == expectedHash)
}

@Test func createKeyFromSecretTests() async throws {
  let hashedPassword = "$argon2id$v=19$m=1000,t=256,p=4$OGQ5YzFhZmYxZDQwYmQ0ZDQ2MjJiMWUxMDcwMDlhZTE2NjQ2NTc2NmNlYWE0MjljZTBkY2Y2NDEwOWUyN2VjZA$2RlfBsO9/5y410QJwsksT8YDTuLqGqYqbo7BrQ8pmyI"
  let salt = "8d9c1aff1d40bd4d4622b1e107009ae166465766ceaa429ce0dcf64109e27ecd"
  let expectedKey = "fQixWKitNA+4IHJqa9SQC0xHgZSBdoDfc2GDjSf1p78="
  let masterSecrete = SRPClient.createKeyFromSecret(secret: hashedPassword, salt: salt)
  #expect(expectedKey == masterSecrete)
}

@Test func deriveSessionTests() async throws {
  let privateKeyStr = "36fb2dd1cfe1967ff797ad4ed2251f7e512fdab6ef6876189e49e479bc7276c0"
  let serverEphemeralPublic = "2fb36eb674673f527ff6475e5c9040392c39770832bcb14741b200add0b6d6362c75388e84c0177f3b48536dfa75de0f5215a49af096e3fb2cd64e4e1849696769b04186bd8045a297448f36d7ea9486280158f6184c7ea12a0306fd57ac0e68a13b8b7932e6a687071c6407aa95fe1ef2ef762080c8a763e343e976eedd96f76f46a85f31ee370abda627a910d971db068efd862fc3e87d84a9ca251c7dede7eeb830cc6312514480f72f396c9678389b017242ce4b770420790c5ae0029f791ac99906931c4c626b997fbdaa7c1b2e31f889dbb7ffa5a16a648519c2bd64c1a24f677c69219ca71dc7320f7c809047a2241fc5242598a2947223342836c5a5"
  let salt = "8d9c1aff1d40bd4d4622b1e107009ae166465766ceaa429ce0dcf64109e27ecd"
  let userName = "luantran"
  let privateKey = "ea2d237638addc1a0b4190b7a0039724116d597bb1c67e70a58c9c3c9ce0f95b"
  let expectedProof = "36b09ed76e2897538ccbf08f8bfa61703e89fb4618a6bd1a47694140b8e88f60"
  let expectedKey = "9d385a54a8b4137720465df9ffebc97f7386f161cc7a84a012ef90af14c4e4e5"
  let session = try SRPClient.deriveSession(
    clientSecretEphemeral: privateKeyStr,
    serverPublicEphemeral: serverEphemeralPublic,
    salt: salt,
    username: userName,
    privateKey: privateKey
  )
  #expect(session.proof == expectedProof)
  #expect(session.key == expectedKey)
}
