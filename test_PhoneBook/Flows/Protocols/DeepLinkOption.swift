import Foundation

struct DeepLinkURLConstants {
  static let Onboarding = "onboarding"
  static let Main = "main"
}

enum DeepLinkOption {
  case onboarding
  case main
  
  static func build(with userActivity: NSUserActivity) -> DeepLinkOption? {
    if userActivity.activityType == NSUserActivityTypeBrowsingWeb,
      let url = userActivity.webpageURL,
      let _ = URLComponents(url: url, resolvingAgainstBaseURL: true) {
      //TODO: extract string and match with DeepLinkURLConstants
    }
    return nil
  }
  
  static func build(with dict: [String : AnyObject]?) -> DeepLinkOption? {
    guard let id = dict?["launch_id"] as? String else { return nil }
    switch id {
      case DeepLinkURLConstants.Onboarding: return .onboarding
      case DeepLinkURLConstants.Main: return .main
      default: return nil
    }
  }
}
