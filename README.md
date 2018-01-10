# Flickr-Image-Gallery
[![codebeat badge](https://codebeat.co/badges/c3eb8333-107d-4c4a-818d-062e0c9056a1)](https://codebeat.co/projects/github-com-jtomanik-flickr-image-gallery-master)
[![Build Status](https://www.bitrise.io/app/dfe571a6bc292758/status.svg?token=8MgOQhpkYACfxea3dFrYhQ&branch=master)](https://www.bitrise.io/app/dfe571a6bc292758)

# Evolving Architecture
In this repository, I'd like to explain how to transform an architecture of iOS app from the classic MVC to the Clean architecture.

### Transforming mindset
Last year I was at Boiling Frogs Conference where I had a chance to attend a talk by Jarosław Pałka ([video, polish only](https://www.youtube.com/watch?v=YYAcugwEZTI)) where he clearly articulated what I've been trying to put in words for a long time.

> 
> What is architecture?
> 
> Architecture is a **process** which goal is to **transform** your system from one structure to another structure in order to achieve a new goal.
> 
> Jarosław Pałka 
> 

I'll try to briefly describe the key thoughts I had after that talk.

### It's the Complexity, Stupid!
Let's have a look at the context in which we operate. As professional developers we are paid to create software. For each business, that is our client, the software should increase its profit. And since every business constantly aims to increase its profit, it also keeps adding new features.

So for as long as the software we create is used, new features will be added.

However, each new feature increases the complexity and the software's size. This rising complexity reduces the pace at which we can continue adding new features. The following graph (from Jarosław's presentation) illustrates the concept.
![complexity](https://image.slidesharecdn.com/patternsfororganicarchitecture-codedive-141120142839-conversion-gate01/95/patterns-for-organic-architecture-codedive-26-638.jpg?cb=1416493747)
This leads us to an interesting conclusion. In each particular case the complexity will keep increasing and eventually we (and businesses) will find ourselves unable to add more features. This happens because the costs resulting from the complexity will eventually match all our available resources. Another slide from that presentation illustrates this problem.
![backlog](https://image.slidesharecdn.com/patternsfororganicarchitecture-codedive-141120142839-conversion-gate01/95/patterns-for-organic-architecture-codedive-27-638.jpg?cb=1416493747)
At this point the mythical *rewriting* often occurs as we, developers, jump to use the newest, the coolest, the shiniest "architecture" that is supposed to bring us to the promised land of restored productivity... 
and it works...
for some time... 
until we find ourselves again in the same spot.

We need to face the reality and acknowledge that most of the software (except for the most trivial projects) is developed in *write-rewrite* cycles. We must also notice that in each cycle our software has a particular structure (which we call architecture). In every single case regardless of that structure the development eventually comes to a point where introducing even a slight change requires a huge effort. If the software is still useful for the business there is a reason to do a rewrite and start a new cycle. Only when we take the *write-rewrite* cycles into consideration we can easily understand the differences between different architectures.

**I believe that each Architecture (structure of a software system) has its complexity capacity. That means there is a certain and limited level of complexity (introduced by features) you can add to the system. After reaching that level of complexity the law of diminishing returns makes further development unsustainable.**

Therefore we, as developers, need to be prepared to handle ever-increasing complexity in a software that we are creating. This repository aims to illustrate how to transform one of the simplest architectural structures (MVC) into one that can accommodate very complex business requirements.

# 1. MVC
Code for this milestone is available on a branch [milestone/mvc](https://github.com/jtomanik/Flickr-Image-Gallery/tree/milestone/mvc/Flickr%20Image%20Gallery/Flickr%20Image%20Gallery/App)

I'm not going to go into details of this architectural structure but for the sake of completeness let's refresh some basics.
MVC simply divides a system into 3 parts:

#### Model
The model represents domain knowledge. The business logic and business rules are encapsulated in the Model. Model object is completely ignorant of the UI and is managed internally by Controller. 

#### View
A view can be any output representation of information, such as a chart or a diagram.

#### Controller
The controller's job is to take the user's input and figure out what to do with it. The controller is responsible for updating Model.

The granularity of the MVC division is very coarse. There are many specific implementations that differ from each other, so there is no well-defined standard definition.

### Classic MVC
When presenting classic * flavour* of MVC I feel it needs to be stress that there's not just one view and controller. You have a view-controller pair for each element of the screen, each of the controls and the screen as a whole. In my opinion this is, probably, the most important aspect overlooked by many developers coming from Apple's ecosystem.
![MVC](https://lh5.googleusercontent.com/aKUKKKNm13iKD2yIkJrIptqgC8_m10WTotN0zsR2n0MchPjRnOUtvzaECH61yf7WnVcDMgMLx4nipGTjYmVZe4qarj4KM6eUm_i6aZMAlXFOodPUFX0WhW6aJpqhN5947JXsSby9cbc)

#### Cocoa MVC
It is caused by the fact that MVC pattern on Apple's platforms looks very different. In Cocoa *flavour* of MVC a controller is the glue between view and model. That means controller has to handle many different tasks like:

* calling the business logic and bind the results to the view
* managing the view elements
* transforming the data coming from the model layer into a UI friendly format
* navigation logic
* managing the UI state
* and many more …
![Cocoa MVC](https://lh3.googleusercontent.com/0t_eRway7FiYBERfcjTD10R30ArvNuvW3AouuMzHsup8xAyUQsrv2jDOJFXPCIk3QdOVkPfMAkSNvxIUDjmVp_u7DAWJ3K2yuErSNObM7VnYZJ9OAt4bZdxDi-aSB2KRhhb18e-lUU4)


#### Massive MVC
Having all of those responsibilities, controllers often get huge, hard to maintain and to test. In practice View and the Controller become tightly coupled and it is difficult to say they are separated. That often leads to a situation commonly called as Massive View Controller. 
![Massive MVC](https://lh5.googleusercontent.com/oRdqf3J7Fs4hHJM0SUk4qpjugvbg2ZoqVF5bIOqPiV6x-BIBgKHxergNKQjifdqKAwu-x4CTmZMiQRasbHavay0pgjqKwpJ5u8eeN37SNV7eArGtfaV-flla1ixQgX6hNvAQnIxDOGs)

I believe that each Massive MVC codebase is a perfect example of a system whose complexity overgrow its structure's capabilities to the point where further growth is unsustainable. That is the best sign that your architecture should change some time ago.


#### MVC summary
Although it has many shortcomings MVC as a system's structure offers some benefits as well. It has low overhead in terms of complexity and amount of code it introduces just to support itself. However the price for that is very low overall complexity capacity. Therefore you can very quickly experience negative effects affecting the development process. 

I use this pattern whenever I need to prepare small demo or make a Proof-of-Concept. I believe it's ideal for 1-2 week jobs that need to be made cheaply and could be disposed of easily. However I would be very careful using it in the product, even when creating the Minimum Viable Product.

In my opinion MVC architecture clearly underperforms when used in complex real-life projects. However very often we can find ourselves in a situation where we have to work with what we have. Very often that is a software that was created in MVC pattern and reached its limits. Following sections will show what we can do to transform such system.

# 2. MVP / MVVM
Code for this milestone is available on a branch [milestone/mvp-mvvm](https://github.com/jtomanik/Flickr-Image-Gallery/tree/milestone/mvp-mvvm/Flickr%20Image%20Gallery/Flickr%20Image%20Gallery/App)

Problems with MVC are known and lead to the creation of, among others, MVP (and MVVM) patterns. I'd like to quickly present key concepts of those two architectural structures and how they can be useful in our transformation of MVC. Later on I'll use as a base for my implementation.

### Passive View MVP
This is one of the *flavours* of the MVP pattern described by [Martin Fowler](https://martinfowler.com/eaaDev/PassiveScreen.html) and called Passive View. It reduces the behaviour of the UI components to the absolute minimum by using a controller that not just handles responses to user events, but also does all the updating of the view. This allows testing to be focused on the controller with little risk of problems in the view.

The controller called the Presenter ensure that any code that manipulates presentation only manipulates presentation, pushing all domain and data source logic into clearly separated areas of the program within the Model layer.

![Passive View MVP](https://lh5.googleusercontent.com/BsyoisT3TaJ1cSMkuCY21dxfbEoskcIci_Z2T5Tx3SxGN9wilSygz1Mnv-rNWHIoioDBFC-HaKhC2jj1ip5ZdYNoku0w0yE-SuU5zYHTlhvShr4z96S_snhja3khGUIFz1FTdZbjrws)

### MVVM
MVVM is a variation of MVP design pattern. MVVM abstracts a view's state and behaviour in the same way, but a Presentation Model abstracts a view in a manner not dependent on a specific user-interface platform.

The view model is an abstraction of the view exposing public properties and commands. Instead of the controller of the MVC pattern, or the presenter of the MVP pattern, MVVM has a binder. In the view model, the binder mediates communication between the view and the data. The view model has been described as a state of the data in the model.

Declarative data and command-binding are implicit in the MVVM pattern. The binder frees the developer from being obliged to write boiler-plate logic to synchronize the view model and view. 

![MVVM](https://lh5.googleusercontent.com/2KjOZ5l2L9Eo6-KT9rshl70ondzCX5eZi3WbeenWFGG8zoKB2idhvBtFKMIsKRe8j7DGjXZQb28J6Ss1jU5vBbMubOSLTOgRke2PIGZa4z2m6r8lVpW65qYfDO1GlND5zcFnb9M1wV0)

### Reactive binding

Data and command binding is a powerful technique, unfortunately there is no native binding functionality provided by iOS or Swift. Therefore I use RxSwift to provide it.

RxSwift is a reactive programming framework from ReactiveX. This is a Swift version of Rx and relies on the observable pattern. If there’s a data change or event from Observable, the Observer can perform something. More details of RxSwift can be found [here](https://github.com/ReactiveX/RxSwift).

Introducing Reactive programming techniques into the app is a serious architectural decision and comes at a cost, yet I believe benefits it provides are worth the effort.

### Implementation
I am going to base my implementation heavily on Reactive techniques so the process I'm describing here has to account for differences this decision implies. Please be aware that some choices I made may be unnatural if used with callbacks or the delegate pattern.

In order to avoid misconceptions and to show how what I'm proposing relates to already mentioned MVC, MVP, MVVM patterns I want to explicitly define elements of my structure.

#### The View
As mentioned before Views and View Controllers are technically distinct components, yet on iOS they almost always go hand-in-hand together, paired.
To formalize this connection I will call UIView-UIViewController pair **the View**.

It has following characteristics:

* View owns the Presenter
* View contains all the layout logic
* View contains all the necessary subviews
* View delegates all user interactions to the Presenter
* View's appearance is controlled through Display Models that encapsulate all data to be presented
* View binds to reactive properties of the presenter to get updates about DisplayModel changes

Note: sometimes Display Model is a simple datatype, like String, sometimes it's a custom data structure. Yet in all cases it should not be dependant on system's UI framework (like UIKit)

#### The Presenter
**The Presenter** is responsible for driving the View. It is a middle ground between "Presenter" and "ViewModel" from MVP and MVVM architectures. 
From MVVM it borrows binding techniques and unawareness of the View and whole UI Layer. From MVP it inherits focus on the presentation and user interaction logic.
 
It has following characteristics:

 * Presenter is owned by the View
 * Presenter has no references to the View
 * Presenter has all its dependencies injected
 * Presenter contains all presentation logic
 * Presenter contains the logic to handle user interactions
 * Presenter provides reactive data binding mechanism to the View via DisplayModels to update Views' appearance automatically
 * Presenter has no dependencies to UIKit
 * Presenter can be easily tested

#### The Model
The model, so far, has little changes. It contains basic business properties and is created by the service which is responsible for the data access. The biggest change is the fact that I hid it behind an abstraction (Swift's `protocol`) in order to be able to inject service into the Presenter.

Moreover current implementation of the service is using mock data. I find it very useful as it allows to defer writing an implementation of the networking code. Very often it allows separating app development from the backend development. Additionally we can reuse our mock generators in tests.

#### MVP / MVVM Summary
In this step we made our first clear division of responsibilities. We have all our layout and display procedures in the View while all presentation logic is in the Presenter. Our View is "dumb" and can be excluded from testing. Additionally our presenter is unaware of the View, has its data source dependency injected, therefore, we can easily test it.

We can see this architecture is more complex and requires more code to implement, yet in my opinion it provides us with much-grated complexity capacity and flexibility. This allows us to introduce changes and new features much easier than MVC and we can experience development slowdown later than in MVC.

Just as MVC is great for simple apps I think this structure when combined with the next step can provide an efficient architecture for many medium size (and complexity) apps. This should be enough to handle Minimum Viable Product type apps.


# 3. Coordinators, Flow Controllers, Routers and Connectors
Code for this milestone is available on a branch [milestone/coordinator-connector](https://github.com/jtomanik/Flickr-Image-Gallery/tree/milestone/coordinator-connector/Flickr%20Image%20Gallery/Flickr%20Image%20Gallery/App)

Unfortunately previously mentioned MVP/MVVM have same problems as MVC when it comes to the task of navigating between different views within the same app. That code doesn't really fit within the View or the Presenter and very often it ends up in some kind of "code bucket". In case of iOS that, very often, is an `AppDelegate`. Fortunately this problem was already solved. In recent years that issue was nicely addressed by the introduction of [coordinators](http://khanlou.com/2015/10/coordinators-redux/), [injecting coordinators](http://aplus.rs/2017/mvc-c-injecting-coordinator-pattern-in-uikit/) or [flow controllers](http://merowing.info/2016/01/improve-your-ios-architecture-with-flowcontrollers/). The following image is an example of the Coordinator pattern:
![mvc+coordinator](https://lh4.googleusercontent.com/KRu65gXhYf5brpzpFPwmB-Amw0YSSc_nnb4MgR3atFzvxwWYAjWlHWdmQyu_KaidXXfqt5-OFnt_lwtir3BBuUUpXvPfSO6XwIUxqLqpnxR2xxwTUh5lDghhkGLrFe_mcSfeFwuOXgI)

I will show how well those patterns work with concepts I have already introduced and how they can be incorporated into the effort to further transform system's architecture.

### Divide and conquer
In this step I'll apply the same strategy, *divide and conquer*, as previously. I'll identify a specific responsibility and move it to a new layer. I'm going to start by defining what problem I want to solve.

**Neither the View nor the Presenter should know or care about the hierarchy they are presented in.**

To solve this problem lets define a new layer of our system's structure:

#### The Connector
The Connector is inspired by the concepts of Coordinators, Flow Controllers or Routers.
Name Connector was chosen to avoid confusion, a Connector can be described as a component that is responsible for certain navigation flow and lifecycle of Views present in that flow.
It has following characteristics:

 * Connector creates instances of dependencies needed
 * Connector creates and configures instances of the Presenters
 * Connector creates and configures instances of the Views
 * Connector injects dependencies into the Views and Presenters
 * Connector shows and hides Views
 * Connector can child connectors that can handle 

![mvp+connectector](https://lh3.googleusercontent.com/4MoGEGHoW3ycOYjObo4yEL8EbKK_jevcaiQZ_eyVz699yhDjRY9aIDW1wAPtYCduz-b-ZGcNyDcASbPscqE7SDsSYV3Pp5atfbQRa7qkVEKDGC9c2uoCNthsZnJwLuuQg56DvpswAHc)

With the connector we can move code creating our main View to it and add new View (detail view) with little impact on the existing code.

#### The Presenter
To keep our Presenter testable we are hiding Connector behind a protocol that abstracts its functionality. That allows us to test if the Presenter properly reacts to user's interaction by asking the connector to show detail screen.

#### Implementation
One note about my implementation. I have made a decision that Connector should be own by the app delegate, however that is not the only option. The View could also own the connector depending on the navigation flow of the app. I'm afraid that there is no rule for that as, in my opinion, an implementation should follow the UX design.

#### Connector summary
Yet again we have transformed our system's structure to solve new problems and accommodate new needs. Although the complexity (and code) needed to implement this architecture have risen again, we have achieved an increase in flexibility and overall complexity it can handle without struggles.

Although I, personally, rarely stop at this stage I know people using this structure with great results. In my opinion this is a base level for anything that can be considered as a shippable product. 

# 4. Clean Architecture
This milestone lives on a branch [milestone/usecases-repositories](https://github.com/jtomanik/Flickr-Image-Gallery/tree/milestone/usecases-repositories/Flickr%20Image%20Gallery/Flickr%20Image%20Gallery/App)

Until this moment I wasn't touching Model layer apart from hiding it behind an abstraction. For very basic CRUD apps that would probably get us quite far. However in real life business logic tend to grow quickly and data access isn't straightforward. To solve those remaining issues I'll turn to Uncle Bob.

#### Clean Uncle
More than half a decade ago Rober C. Martin (known as Uncle Bob) described his take on the [ideal architecture](https://8thlight.com/blog/uncle-bob/2012/08/13/the-clean-architecture.html) and called it the Clean architecture. As a reminder here's an overview:
![clean](http://tidyjava.com/wp-content/uploads/2017/03/another_productive_circle.png)

Just as with every other architecture it comes in many *flavours* with VIPER being the most well-known implementation for the iOS platform. However I am not trying to implement VIPER here.

I'll focus on how we can clean up a current Model layer in order to separate business logic from the data access logic and arrive at a custom implementation of the Clean architecture. First I'd like to define what Entities and Use Cases are:

#### The Entity
Entities encapsulate a Domain business rules. An entity can be an object with methods, or it can be a set of data structures and functions. 

#### The Interactor
Interactors abstract rich business logic. They are the boundary between Presentation and Business (Domain) Logic

#### The Use Case
Use Cases are concrete implementations of Interactors. Use Cases have no knowledge of anything other than the business rules and Domain Entities which they're responsible for. They can manipulate entities, however all communication with the outside world go through Gateways.

Next I'm going to define how data access logic should be divided:

#### The (Entity) Gateway
An abstract boundary that encapsulates the semantic gap between the object-oriented domain layer represented by the Use Cases and the relation-oriented persistence layer represented by the Repositories.

#### The Repository
Repositories are concrete implementations of gateways (boundaries). A Repository mediates between the data source and the business domain of the application. It queries the data source for the data, maps the data from the data source to a business entity, and persists changes in the business entity to the data source. A repository separates the business logic contained in the Use Cases from the interactions with the underlying data source or backend API.

All that leads to the structure as shown here:
![clean](https://lh3.googleusercontent.com/PCoTVJ-p7CtPVRFtGirsO0RGlkK10tYIds5KCG-MXZxvz2osD1cY0J3_AynuzAC636_HrXaT-fKItsmHVlX5vzmhJ0fEk0TBC5b7-qROIbwo4qW53U_0xGRsjDF0JpvhysTUEezFy9Y)

#### Boundaries
I have introduced the first boundary together with the Presenter however without saying that explicitly. They are one of the core aspects of the clean architecture and they deserve some attention. Boundaries exist between each circle in Uncle's Bob diagram. Boundaries prevent inner circles from knowing about outer Circles a Dependency Inversion principle in action. In practice boundary is represented by one or more abstractions (that is `protocol`s) that hide upper circles.


#### The Facade
The last element of our final structure is the Facade. I use this pattern to provide simplified access to all abstract interactors. I know many people, in their implementations of Clean architecture, are using the Factory pattern to return Use Cases. However in my opinion Facade pattern fits better with an implementation based on Reactive programming. 

#### Summary
I've been using clean architecture in all my projects for over a year. While I agree it comes with a lot of overhead in terms of internal complexity and the amount of code I had greatly benefited from great flexibility it brings to large projects. I am aware that the code as simple as one in this repository cannot convey benefits of clean architecture. I am hoping though that people who faced themselves limits of simpler architectures will be able to appreciate clean architecture fully.

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
This project is using `cspell` to perform spell checking and contains files used by it.
If you would like to use it go to [github.com](https://github.com/Jason3S/cspell) and follow instructions to install.

I use those tools mostly as final checks before submitting PR.

# Building this project
Check out this repo, make sure you have all build tools installed,  then open `Flickr Image Gallery.xcworkspace` and `Run`.

