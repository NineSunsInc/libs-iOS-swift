// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "NineSunsSDK",
  platforms: [
    .iOS(.v14)
  ],
  products: [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .library(
      name: "NineSunsSDK",
      targets: ["NineSunsSDK"]),
    .library(
      name: "NSCatCrypto",
      targets: ["NSCatCrypto"]),
  ],
  dependencies: [
    .package(url: "https://github.com/bitmark-inc/tweetnacl-swiftwrap.git", from: "1.0.0"),
    .package(url: "https://github.com/IBM-Swift/BlueCryptor.git", from: "2.0.2"),
    .package(url: "https://github.com/attaswift/BigInt.git", from: "5.3.0"),
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .target(name: "Argon2",
            path: "Sources/NSCatCryptoObjectC/ModuleMaps/Argon2",
            publicHeadersPath: "ObjcHeader"),
    .target(name: "MD6",
            path: "Sources/NSCatCryptoObjectC/ModuleMaps/MD6",
            publicHeadersPath: "ObjcHeader"),
    .target(
      name: "SHA3",
      path: "Sources/NSCatCryptoObjectC/ModuleMaps/SHA3",
      publicHeadersPath: "ObjcHeader"),
    .target(
      name: "NSCatCrypto",
      dependencies: [.target(name: "Argon2"), .target(name: "MD6"), .target(name: "SHA3")],
      path: "Sources/NSCatCrypto"
    ),
    .target(
      name: "NineSunsSDK",
      dependencies: [
        .product(name: "TweetNacl", package: "tweetnacl-swiftwrap"),
        .product(name: "BigInt", package: "BigInt"),
        .product(name: "Cryptor", package: "BlueCryptor"),
        .target(name: "Argon2"),
        .target(name: "MD6"),
        .target(name: "SHA3"),
      ]
    ),
    .testTarget(
      name: "NineSunsSDKTests",
      dependencies: ["NineSunsSDK", "NSCatCrypto"]
    ),
  ],
  swiftLanguageModes: [.v5]
)
