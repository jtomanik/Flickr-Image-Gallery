// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import UIKit.UIImage

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

struct ImageAsset: ImageProvider {

  fileprivate(set) var name: String

  var image: UIImage {
    let bundle = Bundle(for: BundleToken.self)
    let image = UIImage(named: name, in: bundle, compatibleWith: nil)
    guard let result = image else {
        fatalError("Unable to load image named \(name).")
    }
    return result
  }
}
// swiftlint:disable identifier_name line_length nesting type_body_length type_name
enum Asset {
  enum NavBar {
    static let backGrey = ImageAsset(name: "backGrey")
  }
  // swiftlint:disable trailing_comma
  static let allImages: [ImageAsset] = [
    NavBar.backGrey,
  ]
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

extension UIImage {

  @available(iOS 1.0, tvOS 1.0, watchOS 1.0, *)
  convenience init!(asset: ImageAsset) {
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
  }
}

private final class BundleToken {}
