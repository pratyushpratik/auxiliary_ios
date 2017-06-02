// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation
import UIKit

// swiftlint:disable file_length
// swiftlint:disable line_length
// swiftlint:disable type_body_length

protocol StoryboardSceneType {
  static var storyboardName: String { get }
}

extension StoryboardSceneType {
  static func storyboard() -> UIStoryboard {
    return UIStoryboard(name: self.storyboardName, bundle: Bundle(for: BundleToken.self))
  }

  static func initialViewController() -> UIViewController {
    guard let vc = storyboard().instantiateInitialViewController() else {
      fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
    }
    return vc
  }
}

extension StoryboardSceneType where Self: RawRepresentable, Self.RawValue == String {
  func viewController() -> UIViewController {
    return Self.storyboard().instantiateViewController(withIdentifier: self.rawValue)
  }
  static func viewController(identifier: Self) -> UIViewController {
    return identifier.viewController()
  }
}

protocol StoryboardSegueType: RawRepresentable { }

extension UIViewController {
  func perform<S: StoryboardSegueType>(segue: S, sender: Any? = nil) where S.RawValue == String {
    performSegue(withIdentifier: segue.rawValue, sender: sender)
  }
}

enum StoryboardScene {
  enum Home: String, StoryboardSceneType {
    static let storyboardName = "Home"

    case addProfessionalViewControllerScene = "AddProfessionalViewController"
    static func instantiateAddProfessionalViewController() -> SaloonVendor.AddProfessionalViewController {
      guard let vc = StoryboardScene.Home.addProfessionalViewControllerScene.viewController() as? SaloonVendor.AddProfessionalViewController
      else {
        fatalError("ViewController 'AddProfessionalViewController' is not of the expected class SaloonVendor.AddProfessionalViewController.")
      }
      return vc
    }

    case bookingsViewControllerScene = "BookingsViewController"
    static func instantiateBookingsViewController() -> SaloonVendor.BookingsViewController {
      guard let vc = StoryboardScene.Home.bookingsViewControllerScene.viewController() as? SaloonVendor.BookingsViewController
      else {
        fatalError("ViewController 'BookingsViewController' is not of the expected class SaloonVendor.BookingsViewController.")
      }
      return vc
    }

    case changePasswordViewControllerScene = "ChangePasswordViewController"
    static func instantiateChangePasswordViewController() -> SaloonVendor.ChangePasswordViewController {
      guard let vc = StoryboardScene.Home.changePasswordViewControllerScene.viewController() as? SaloonVendor.ChangePasswordViewController
      else {
        fatalError("ViewController 'ChangePasswordViewController' is not of the expected class SaloonVendor.ChangePasswordViewController.")
      }
      return vc
    }

    case homeTabBarViewControllerScene = "HomeTabBarViewController"
    static func instantiateHomeTabBarViewController() -> SaloonVendor.HomeTabBarViewController {
      guard let vc = StoryboardScene.Home.homeTabBarViewControllerScene.viewController() as? SaloonVendor.HomeTabBarViewController
      else {
        fatalError("ViewController 'HomeTabBarViewController' is not of the expected class SaloonVendor.HomeTabBarViewController.")
      }
      return vc
    }

    case myProfessionalsViewControllerScene = "MyProfessionalsViewController"
    static func instantiateMyProfessionalsViewController() -> SaloonVendor.MyProfessionalsViewController {
      guard let vc = StoryboardScene.Home.myProfessionalsViewControllerScene.viewController() as? SaloonVendor.MyProfessionalsViewController
      else {
        fatalError("ViewController 'MyProfessionalsViewController' is not of the expected class SaloonVendor.MyProfessionalsViewController.")
      }
      return vc
    }

    case mySubscriptionViewControllerScene = "MySubscriptionViewController"
    static func instantiateMySubscriptionViewController() -> SaloonVendor.MySubscriptionViewController {
      guard let vc = StoryboardScene.Home.mySubscriptionViewControllerScene.viewController() as? SaloonVendor.MySubscriptionViewController
      else {
        fatalError("ViewController 'MySubscriptionViewController' is not of the expected class SaloonVendor.MySubscriptionViewController.")
      }
      return vc
    }

    case profileViewControllerScene = "ProfileViewController"
    static func instantiateProfileViewController() -> SaloonVendor.ProfileViewController {
      guard let vc = StoryboardScene.Home.profileViewControllerScene.viewController() as? SaloonVendor.ProfileViewController
      else {
        fatalError("ViewController 'ProfileViewController' is not of the expected class SaloonVendor.ProfileViewController.")
      }
      return vc
    }

    case requestsViewControllerScene = "RequestsViewController"
    static func instantiateRequestsViewController() -> SaloonVendor.RequestsViewController {
      guard let vc = StoryboardScene.Home.requestsViewControllerScene.viewController() as? SaloonVendor.RequestsViewController
      else {
        fatalError("ViewController 'RequestsViewController' is not of the expected class SaloonVendor.RequestsViewController.")
      }
      return vc
    }

    case revenueDailyViewControllerScene = "RevenueDailyViewController"
    static func instantiateRevenueDailyViewController() -> SaloonVendor.RevenueDailyViewController {
      guard let vc = StoryboardScene.Home.revenueDailyViewControllerScene.viewController() as? SaloonVendor.RevenueDailyViewController
      else {
        fatalError("ViewController 'RevenueDailyViewController' is not of the expected class SaloonVendor.RevenueDailyViewController.")
      }
      return vc
    }

    case revenueHeaderViewControllerScene = "RevenueHeaderViewController"
    static func instantiateRevenueHeaderViewController() -> SaloonVendor.RevenueHeaderViewController {
      guard let vc = StoryboardScene.Home.revenueHeaderViewControllerScene.viewController() as? SaloonVendor.RevenueHeaderViewController
      else {
        fatalError("ViewController 'RevenueHeaderViewController' is not of the expected class SaloonVendor.RevenueHeaderViewController.")
      }
      return vc
    }

    case revenueMonthlyViewControllerScene = "RevenueMonthlyViewController"
    static func instantiateRevenueMonthlyViewController() -> SaloonVendor.RevenueMonthlyViewController {
      guard let vc = StoryboardScene.Home.revenueMonthlyViewControllerScene.viewController() as? SaloonVendor.RevenueMonthlyViewController
      else {
        fatalError("ViewController 'RevenueMonthlyViewController' is not of the expected class SaloonVendor.RevenueMonthlyViewController.")
      }
      return vc
    }

    case revenueViewControllerScene = "RevenueViewController"
    static func instantiateRevenueViewController() -> SaloonVendor.RevenueViewController {
      guard let vc = StoryboardScene.Home.revenueViewControllerScene.viewController() as? SaloonVendor.RevenueViewController
      else {
        fatalError("ViewController 'RevenueViewController' is not of the expected class SaloonVendor.RevenueViewController.")
      }
      return vc
    }

    case revenueWeeklyViewControllerScene = "RevenueWeeklyViewController"
    static func instantiateRevenueWeeklyViewController() -> SaloonVendor.RevenueWeeklyViewController {
      guard let vc = StoryboardScene.Home.revenueWeeklyViewControllerScene.viewController() as? SaloonVendor.RevenueWeeklyViewController
      else {
        fatalError("ViewController 'RevenueWeeklyViewController' is not of the expected class SaloonVendor.RevenueWeeklyViewController.")
      }
      return vc
    }
  }
  enum LaunchScreen: StoryboardSceneType {
    static let storyboardName = "LaunchScreen"
  }
  enum Main: String, StoryboardSceneType {
    static let storyboardName = "Main"

    static func initialViewController() -> UINavigationController {
      guard let vc = storyboard().instantiateInitialViewController() as? UINavigationController else {
        fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
      }
      return vc
    }

    case forgetPasswordViewControllerScene = "ForgetPasswordViewController"
    static func instantiateForgetPasswordViewController() -> SaloonVendor.ForgetPasswordViewController {
      guard let vc = StoryboardScene.Main.forgetPasswordViewControllerScene.viewController() as? SaloonVendor.ForgetPasswordViewController
      else {
        fatalError("ViewController 'ForgetPasswordViewController' is not of the expected class SaloonVendor.ForgetPasswordViewController.")
      }
      return vc
    }

    case loginViewControllerScene = "LoginViewController"
    static func instantiateLoginViewController() -> SaloonVendor.LoginViewController {
      guard let vc = StoryboardScene.Main.loginViewControllerScene.viewController() as? SaloonVendor.LoginViewController
      else {
        fatalError("ViewController 'LoginViewController' is not of the expected class SaloonVendor.LoginViewController.")
      }
      return vc
    }

    case packagesViewControllerScene = "PackagesViewController"
    static func instantiatePackagesViewController() -> SaloonVendor.PackagesViewController {
      guard let vc = StoryboardScene.Main.packagesViewControllerScene.viewController() as? SaloonVendor.PackagesViewController
      else {
        fatalError("ViewController 'PackagesViewController' is not of the expected class SaloonVendor.PackagesViewController.")
      }
      return vc
    }
  }
  enum ViewProfile: String, StoryboardSceneType {
    static let storyboardName = "ViewProfile"

    case editProfileViewControllerScene = "EditProfileViewController"
    static func instantiateEditProfileViewController() -> SaloonVendor.EditProfileViewController {
      guard let vc = StoryboardScene.ViewProfile.editProfileViewControllerScene.viewController() as? SaloonVendor.EditProfileViewController
      else {
        fatalError("ViewController 'EditProfileViewController' is not of the expected class SaloonVendor.EditProfileViewController.")
      }
      return vc
    }

    case offersViewControllerScene = "OffersViewController"
    static func instantiateOffersViewController() -> SaloonVendor.OffersViewController {
      guard let vc = StoryboardScene.ViewProfile.offersViewControllerScene.viewController() as? SaloonVendor.OffersViewController
      else {
        fatalError("ViewController 'OffersViewController' is not of the expected class SaloonVendor.OffersViewController.")
      }
      return vc
    }

    case reviewsViewControllerScene = "ReviewsViewController"
    static func instantiateReviewsViewController() -> SaloonVendor.ReviewsViewController {
      guard let vc = StoryboardScene.ViewProfile.reviewsViewControllerScene.viewController() as? SaloonVendor.ReviewsViewController
      else {
        fatalError("ViewController 'ReviewsViewController' is not of the expected class SaloonVendor.ReviewsViewController.")
      }
      return vc
    }

    case servicesViewControllerScene = "ServicesViewController"
    static func instantiateServicesViewController() -> SaloonVendor.ServicesViewController {
      guard let vc = StoryboardScene.ViewProfile.servicesViewControllerScene.viewController() as? SaloonVendor.ServicesViewController
      else {
        fatalError("ViewController 'ServicesViewController' is not of the expected class SaloonVendor.ServicesViewController.")
      }
      return vc
    }

    case viewProfileHeaderViewControllerScene = "ViewProfileHeaderViewController"
    static func instantiateViewProfileHeaderViewController() -> SaloonVendor.ViewProfileHeaderViewController {
      guard let vc = StoryboardScene.ViewProfile.viewProfileHeaderViewControllerScene.viewController() as? SaloonVendor.ViewProfileHeaderViewController
      else {
        fatalError("ViewController 'ViewProfileHeaderViewController' is not of the expected class SaloonVendor.ViewProfileHeaderViewController.")
      }
      return vc
    }

    case viewProfileViewControllerScene = "ViewProfileViewController"
    static func instantiateViewProfileViewController() -> SaloonVendor.ViewProfileViewController {
      guard let vc = StoryboardScene.ViewProfile.viewProfileViewControllerScene.viewController() as? SaloonVendor.ViewProfileViewController
      else {
        fatalError("ViewController 'ViewProfileViewController' is not of the expected class SaloonVendor.ViewProfileViewController.")
      }
      return vc
    }
  }
}

enum StoryboardSegue {
}

private final class BundleToken {}
