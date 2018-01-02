// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
enum Localized {

  enum PhotoDetail {
    /// Published on:
    static let publishedOn = Localized.tr("Localizable", "photo_detail.published_on")
    /// Taken by:
    static let takenBy = Localized.tr("Localizable", "photo_detail.taken_by")
    /// Photo Detail
    static let title = Localized.tr("Localizable", "photo_detail.title")
  }

  enum PhotoList {
    /// Photo Feed
    static let title = Localized.tr("Localizable", "photo_list.title")
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension Localized {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
