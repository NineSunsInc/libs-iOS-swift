//
//  NSDecryptionTests.swift
//  NineSunsSDK
//
//

import Testing
@testable import NineSunsSDK

@Test func decryptionTests() async throws {
  let privateKey = "m0m6L4s9blikJ/Ds9c3KVA/Qkqf4jQEoSYLHUo4j3LQ="
  let publicKey = "oaijysb01+sHQ3ao0kc3tF2Wcy9/M7M3a2S7crkBzm4="
  let encryptedKey = "4CmRSsFewgFcy6j1zM5cGJa+uNDdhEySFsj78l3a8r4DShkYhiLHuOPtPVEs06tuRsP2YwW4y/MWFney1F6Ms0gXxJikJ8KR5k2n3BONJlGZ+zsL"
  
  guard let symmetricKey = try? NSDecryption.stringDecryptAsymmetric(
    privateKey: privateKey,
    publicKey: publicKey,
    encryptedText: encryptedKey
  ) else {
    #expect(Bool(false), "Symmetric Key is Null")
    return
  }
  
  let message = "PQUwLjEuMAUwLjAuMSNVc2VyIFNoYXJlZCBFbmNyeXB0ZWQgRGF0YSBEYXRhZ3JhbQwyp15dIUFL+5RHzW+ZmF468vEfYniZwRBGnJga1tmbaOPG0IVMPYg2d7fkDug9hd6v188QTLX5yzXV0YC5xyeArrx22M28EGP1/J5Wl8jN2iFUjAhCnPrSC+JHhX3+3qJK4k8hRcAz5UHW+HvRYSxpmsNCqAHN6HQXtJBPXyH0satcfT0udgDNIQSGAcYETHLtOadKmZuJWSN4TQUiHP4R4knyu8bkQ7i3IhgOwHIhpyjdjMrB540EZ9rW4ygOIXBLOqYLg1O9SsCVrvJ1bThTC4AwmhkjBxinCd202pkRB+PLe+jC8sHMzDfLqL8x+opOpVqte/p4LJOw2OxZfhZU7GM4VzBBb32+5Duvg1wfw7csqMusyfKY/1bJ5uRXbIJrbbkN9OBBNqpaxDYk2Q5pagKxDkcfrtfH9VynL9KR9ALMTkzX2jrbNWBoMt1ISk9Bo2DKHmVpGUZOENhn31J/9QRqxHZzgbU5baeIe8H7tkZwGFP8POwSDaA4cbQqzpBaSL8KKAOjZ8XtKWY29xTlishP0WFGnyci4VHOYGfG/EDq2P2+No6AN0lBN4AMaN4xNfQVZYiVU71CbZg3xYEifSJ7xhXzMDcDDPqLNnVLCfQEkOHNisFJX4/fJR3CSr24sPu6+GngA0SuCq24hi3NIrvB13attEL2iscKL6fFS8wGhUCAZPdO6eDD2EGG4l3SF0SL8CunUn38Wg9Qs3y/EnUpij5OI3Q8wcQIiKAFXohMwn5RUFKoCAurmghvfEUZIRGcF6HwtO56eo2mK3oteROrgTkzhbP0sB/etBJ7qcE9DZKf1BikdI4Sg1QILlGHxLYy/HEHimASLFQ1RJ/1LUgFROqxAxv9uBCuxyLy0oArN+mziCGeVl6zWVny7EVRWUwkb/Ggu9gfNHa7vgG7NQaYRBI3jQW9ZKibKA43JlrQq92j7k1HhRfbT8J96E5+aSDVFWABsWkrcBgjcJhuvA6Wm2Pz0SxxCJLQMv4ezneDquGn+/YjPgn4cglaMutBHjmOzVTixFYKMEuzXFf6k42f2ILc+f+u2qjCWXsdnwPhzQlmjn/S+H8ZXbl7r8Mu5DYdescSmjn5JH0iz2hWfK+vyWAmSnxC21c243z/5VvhycAT/gMT4YRimo3KzXYJ6Py36YRFGzgqXLfb7WSdmQUZCSZm0rd2QG8+bJypiwfYDX1+0ue6YQWIN0lTVKMdCJvKo90MyzqYcmLm6a/XiawYuayv3agYDJdYxLqdCeJENZvb7eHjC1JrvYSalha+1pwP+RviArx5z4PKM4QNRzx+qWmR9YPgJAN36iWEavSRUWiWxYkVh7JO7GrudLgQZkpuhr/29osQnNl7CyvavfPYTnVKZFzXlUgiLB5kqnM5MH3wkS/eO62jLlPtQ9gdO0/+rXoUyYKGWP2B7KPOuzQUMtOg6kumgX0PrzmuCH59OHPawI+5oredtRn+aYIZ14NGsRA1c+Wu3fLl+SltWlhiNYu664Nh9sMuuqjcJKAkQLaZ+jbFGmrEX60b7RRGtWLcMRnDxxvz1A=="
  let datagram = JSONDatagram(type: "User Shared Encrypted Data Datagram")
  
  do {
    let response = try NSDecryption.decryptSymmetric(
      message: message,
      symmetricKey: symmetricKey,
      datagram: datagram
    )
    #expect(response != nil)
  } catch {
    print("Decrypt Symmetric error: \(error)")
  }
}
