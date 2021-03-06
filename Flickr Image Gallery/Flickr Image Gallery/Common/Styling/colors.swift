// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import UIKit.UIColor

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

extension UIColor {

  convenience init(rgbaValue: UInt32) {
    let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
    let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
    let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
    let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}

// swiftlint:disable identifier_name line_length type_body_length

struct ColorName: ColorProvider {
  let rgbaValue: UInt32
  var color: UIColor { return UIColor(named: self) }

  /// 0xffffffff (r: 255, g: 255, b: 255, a: 255)
  static let defaultBackground = ColorName(rgbaValue: 0xffffffff)
}
// swiftlint:enable identifier_name line_length type_body_length

extension UIColor {
  convenience init(named color: ColorName) {
    self.init(rgbaValue: color.rgbaValue)
  }
}
