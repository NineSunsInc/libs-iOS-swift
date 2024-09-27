//
//  NSEnvironment.swift
//  NineSunsSDK
//
//

enum NSEnvironment {
  case dev
  case production
}

extension NSEnvironment {
  var baseUrl: String {
    switch self {
    case .dev:
      return "https://service-platform.dev.ninesuns.io/"
    case .production:
      return "https://service-platform.ninesuns.io/"
    }
  }
}
