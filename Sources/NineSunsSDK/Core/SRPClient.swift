//
//  SRPClient.swift
//  NineSunsSDK
//
//
import BigInt
import NSCatCrypto
import Cryptor
import CryptoKit
import Foundation

class SRPClient {
  
  static func generateEphemeral() -> (secret: String, public: String) {
    let configuration = SRPGroup.N2048
    let a = BigUInt.randomInteger(withExactWidth: 32)
    let A = configuration.g.power(a, modulus: configuration.N)
    
    return (
      secret: String(a, radix: 16),
      public: String(A, radix: 16)
    )
  }
  
  static func hashPasswordWasm(password: String, salt: String) -> String? {
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
    
    return result.stringValue()
  }
  
  static func createKeyFromSecret(secret: String, salt: String) -> String? {
    let content = CatArgon2Crypto.Context()
    content.salt = salt
    content.iterations = 1
    content.parallelism = 1
    content.memory = 1024
    content.hashLength = 32
    content.mode = .argon2id
    content.hashResultType = .hashRaw
    let hash = CatArgon2Crypto(context: content)
    let result = hash.hash(password: secret)
    
    return result.base64StringValue()
  }
  
  static func deriveSession(
    clientSecretEphemeral: String,
    serverPublicEphemeral: String,
    salt: String,
    username: String,
    privateKey: String
  ) throws -> (key: String, proof: String) {
    let a = BigInt(clientSecretEphemeral, radix: 16)!
    let B = BigInt(serverPublicEphemeral, radix: 16)!
    let s = BigUInt(salt, radix: 16)!
    let x = BigInt(privateKey, radix: 16)!
    
    let configuration = SRPGroup.N2048
    
    let A = configuration.g.power(BigUInt(a), modulus: configuration.N)
    
    // Verify B % N > 0
    guard B % BigInt(configuration.N) != 0 else {
      throw NSError(domain: "SRP", code: 2, userInfo: [NSLocalizedDescriptionKey: "Invalid public key"])
    }
    
    let H = Digest.hasher(Digest.Algorithm.sha256)
    let B2 = BigUInt(serverPublicEphemeral, radix: 16)!
    let u = BigUInt(H(A.serialize() + B2.serialize()))
    
    // S = (B - kg^x) ^ (a + ux)
    let k = BigUInt(H(configuration.N.serialize() + configuration.g.serialize()))
    let S12 = BigInt(configuration.g.power(BigUInt(x), modulus: configuration.N))
    let S11 = BigInt(k) * S12
    
    let S1 = B - S11
    let S2 = a + BigInt(u) * x
    let S = S1.power(S2, modulus: BigInt(configuration.N))
    let SUint = BigUInt(S)
    
    let K = BigUInt(H(SUint.serialize()))
    let M = calculateM(username: username, salt: s, A: A, B: B2, K: K)
    
    return (key: String(K, radix: 16), proof: String(M, radix: 16))
  }
  
  static private func calculateM(username: String, salt: BigUInt, A: BigUInt, B: BigUInt, K: BigUInt) -> BigUInt {
    let H1 = Digest.hasher(Digest.Algorithm.sha256)
    let configuration = SRPGroup.N2048
    
    let H_N = BigUInt(H1(configuration.N.serialize()))
    let H_g = BigUInt(H1(configuration.g.serialize()))
    let H_I = H1(username.data(using: .utf8)!)
    
    let M1 = H_N ^ H_g
    let M = M1.serialize() + H_I + salt.serialize() + A.serialize() + B.serialize() + K.serialize()
    
    return BigUInt(H1(M))
  }
}

