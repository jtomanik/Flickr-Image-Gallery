# Flickr-Image-Gallery
[![codebeat badge](https://codebeat.co/badges/c3eb8333-107d-4c4a-818d-062e0c9056a1)](https://codebeat.co/projects/github-com-jtomanik-flickr-image-gallery-master)
[![Build Status](https://www.bitrise.io/app/dfe571a6bc292758/status.svg?token=8MgOQhpkYACfxea3dFrYhQ&branch=master)](https://www.bitrise.io/app/dfe571a6bc292758)

# Evolving Architecture
In this repository, I'd like to explain how to make a journey through iOS architectures starting from the classic MVC and getting to the Clean architecture.

Last year I was at Boiling Frogs Conference where I had a chance to attend a talk by Jarosław Pałka ([video, polish only](https://www.youtube.com/watch?v=YYAcugwEZTI)) where he clearly articulated what I've been trying to put in words for a long time.

> What is software architecture about?
> 
> Architecture should answer two fundamental questions:
> What is the structure of the system?
> What is the purpose of this structure?
> 
> ...
> 
> What is architecture?
> 
> Architecture is a **process** which goal is to **transform** your system from one structure to another structure in order to achieve a new goal.
> 
> Jarosław Pałka 
> 

I'll try to briefly describe the key thoughts I had after that talk.

### It's the Complexity, Stupid!
As professional developers we are paid to create software for business. For each business the software should increase its profit. And since every business constantly aims to increase its profit, it also keeps adding new features.

However, each new feature increases the complexity and the software's size. Thus complexity affects the pace at which we can continue adding new features. The following graph (from Jarosław's presentation) illustrates the concept.
![complexity](https://image.slidesharecdn.com/patternsfororganicarchitecture-codedive-141120142839-conversion-gate01/95/patterns-for-organic-architecture-codedive-26-638.jpg?cb=1416493747)
This leads us to an interesting conclusion. In each particular case the complexity will keep increasing and eventually business will find itself unable to add more features because of the costs resulting from the complexity. Another slide from that presentation illustrates this problem.
![backlog](https://image.slidesharecdn.com/patternsfororganicarchitecture-codedive-141120142839-conversion-gate01/95/patterns-for-organic-architecture-codedive-27-638.jpg?cb=1416493747)
At this point the mythical *rewriting* often occurs as developers jump to use the newest, the coolest, the shiniest "architecture" that is supposed to bring us to the promissed land of the happy code... until we find ourselves again in the same spot.

If we acknowledge that most of the software (except for the most trivial projects) is developed in cycles, we must also admit that in each cycle the software has a particular structure (which we call architecture). In every single case regardles of that structure the development eventually comes to a place where introducing even a slight change requires a huge effort. Only when we take the *write-rewrite* cycles into consideration we can easily understand the differences between architectures.

**Each Architecture (structure of a software system) has its complexity capacity. That means there is a limited level of complexity, represented in features you can add to the system, before the law of diminishing returns makes its further development unprofitable.**

WIP

# 1. MVC
WIP

# 2. MVP / MVVM
WIP

# 3. Coordinators, Flow Controllers, Routers and Connectors
WIP

# 4. Clean Architecture
WIP

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

Note: Due to hardcoded path in one dependency (`Kingfisher`) this project will not compile if your Xcode executable was renamed to something else that default `Xcode.app`.

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

