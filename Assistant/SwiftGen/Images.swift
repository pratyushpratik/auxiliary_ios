// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

#if os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  typealias Image = UIImage
#elseif os(OSX)
  import AppKit.NSImage
  typealias Image = NSImage
#endif

// swiftlint:disable file_length
// swiftlint:disable line_length

// swiftlint:disable type_body_length
enum Asset: String {
  case brixtonParlourTorontoHairStylistInterior = "Brixton-Parlour-Toronto-hair-stylist-interior"
  case icAppointment = "ic_appointment"
  case icAppointmntFill = "ic_appointmnt_fill"
  case icArrowBackWhite = "ic_arrow_back_white"
  case icArrowSmallDown = "ic_arrow_small_down"
  case icArrowSmallLeft = "ic_arrow_small_left"
  case icArrowSmallRight = "ic_arrow_small_right"
  case icArrowSmallUp = "ic_arrow_small_up"
  case icArrowSmall = "ic_arrow_small"
  case icArrow = "ic_arrow"
  case icCall = "ic_call"
  case icChangePassword = "ic_change_password"
  case icCheckBoxOutlineBlank = "ic_check_box_outline_blank"
  case icCheckBox = "ic_check_box"
  case icClock = "ic_clock"
  case icCollections = "ic_collections"
  case icContactPhone = "ic_contact_phone"
  case icCross = "ic_cross"
  case icDelete = "ic_delete"
  case icEdit1 = "ic_edit-1"
  case icEdit = "ic_edit"
  case icEditwp = "ic_editwp"
  case icEmail = "ic_email"
  case icFb = "ic_fb"
  case icGoogle = "ic_google"
  case icHalfStar = "ic_half_star"
  case icHlp2 = "ic_hlp2"
  case icInfo = "ic_info"
  case icKeyboardArrowLeftWhite = "ic_keyboard_arrow_left_white"
  case icKeyboardArrowRightWhite = "ic_keyboard_arrow_right_white"
  case icLocationOn = "ic_location_on"
  case icLogout = "ic_logout"
  case icNoStar = "ic_no_star"
  case icPhotoCameraWhite = "ic_photo_camera_white"
  case icPlusEdit = "ic_plus_edit"
  case icPro = "ic_pro"
  case icProfesionals = "ic_profesionals"
  case icProfileFill = "ic_profile_fill"
  case icReq = "ic_req"
  case icRequestFill = "ic_request_fill"
  case icRevenueFill = "ic_revenue_fill"
  case icRevnue = "ic_revnue"
  case icStar = "ic_star"
  case icTotalEarnings = "ic_total_earnings"
  case icAddAPhotoWhite = "ic_add_a_photo_white"
  case icRemoveCircleOutlineWhite = "ic_remove_circle_outline_white"
  case icAddCircleOutlineWhite = "ic_add_circle_outline_white"
  case noDataFoundIllustration = "no_data_found_illustration"
  case placeholderProfile = "placeholder_profile"

  var image: Image {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS) || os(watchOS)
    let image = Image(named: rawValue, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: rawValue)
    #endif
    guard let result = image else { fatalError("Unable to load image \(rawValue).") }
    return result
  }
}
// swiftlint:enable type_body_length

extension Image {
  convenience init!(asset: Asset) {
    #if os(iOS) || os(tvOS) || os(watchOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.rawValue, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: asset.rawValue)
    #endif
  }
}

private final class BundleToken {}
