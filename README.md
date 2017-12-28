# Flickr-Image-Gallery
develop: [![codebeat badge](https://codebeat.co/badges/a5efa1b3-10b2-4f92-a799-60a37d73247f)](https://codebeat.co/projects/github-com-jtomanik-flickr-image-gallery-develop)

master: [![codebeat badge](https://codebeat.co/badges/c3eb8333-107d-4c4a-818d-062e0c9056a1)](https://codebeat.co/projects/github-com-jtomanik-flickr-image-gallery-master)

# Installing build tools
This project assumes you have several tools installed before you can build it. Those tools are:

1. Xcode 9.2
If you don't have it go to [developer.apple.com](https://developer.apple.com/xcode/) and follow instructions to install.

2. Homebrew
I use Homebrew to manage additional developer tools.
If you don't have it go to [brew.sh](https://brew.sh/) and follow instructions to install.

3. Cocoapods
I use Cocoapods as a dependency manager.
If you don't have it go to [cocoapods.org](https://cocoapods.org/) and follow instructions to install.

4. Swiftlint
I use Swiftlint as way to enforce coding standards.
If you don't have it run `brew install swiftlint` in your terminal.

5. SwiftGen
SwiftGen is required to automatically generate `assets-images.swift` and ` strings.swift` from image assets and localized strings respectively.
If you don't have it run `brew install swiftgen`

## Optional tools
This project contains configuration files for optional tools that I use. Those tools are not necessary to build a project.
use with following tools:

1. Bitrise
This project is using Bitrise as a CI solution and contains files used by Bitrise CLI.
If you would like to use it go to [bitrise.io/cli](https://www.bitrise.io/cli) and follow instructions to install.

2. cspell
This project is using `cspell` to perfrom spell checking and contains files used by it.
If you would like to use it go to [github.com](https://github.com/Jason3S/cspell) and follow instructions to install.

I use those tools mostly as final checks before submitting PR.

# Building this project
Check out this repo, make sure you have all build tools installed,  then open `Flickr Image Gallery.xcworkspace` and `Run`.

