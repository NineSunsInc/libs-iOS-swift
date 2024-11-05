//
//  NSUtilsTests.swift
//  NineSunsSDK
//
//

import Testing
@testable import NineSunsSDK

@Test func hashEmailTest() async {
  let email = "luan.tran+kaka@c0x12c.com"
  let expectEmailHash = "UDcxTy9Wd1dPd1l3aFVscFVnd3ZKaVpJby9sVWRmVkNDSnlvdTR1VDBVWlVCemhLQU9mZE4yMkpkdENLeDZneVlnQUR3NVlzRnEvZUNNZTVQODFaUmc9PQ=="
  let hash = NSUtils.hashEmail(email)
  
  #expect(hash == expectEmailHash)
}

@Test func hashPhoneTest() async {
  let phone = "+84786738948"
  let expectedHash = "rqyUxCL2Pqal2veZEkfwbYmKWvsVna7vv1YML/UNc/IcUMC2VaYXWfnLN4RWjTPDlmH0oTh/AG6WgqhQ+rrpMQ=="
  let hash = NSUtils.hashPhone(phone)
  
  #expect(hash == expectedHash)
}
