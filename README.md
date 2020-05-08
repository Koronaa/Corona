# Corona
Simple iOS app written in Swift 5 to easily keep up to date with the corona virus stats of Sri Lanka using the API provided by [Health Promotion Bureau](https://www.hpb.health.gov.lk/en/api-documentation). 

[![swift-version](https://img.shields.io/badge/swift-5.1-brightgreen.svg)](https://github.com/apple/swift)
[![xcode-version](https://img.shields.io/badge/xcode-11-brightgreen)](https://developer.apple.com/xcode/)
[![rxswift](https://img.shields.io/badge/rxswift-5.1.1-brightgreen)](https://github.com/ReactiveX/RxSwift)
[![license](https://img.shields.io/badge/license-mit-brightgreen.svg)](https://en.wikipedia.org/wiki/MIT_License)
[![blog](https://img.shields.io/badge/blog-techkoronå-brightgreen)](https://techkoronaa.blogspot.com/)


![](corona.gif)


## Supports

iOS 10+


## Pods Used

Corona use number of open source projects to work properly

* [Alamofire](https://github.com/Alamofire/Alamofire)
* [~~SwiftyJSON~~](https://github.com/SwiftyJSON/SwiftyJSON) (Removed in the [85a82b3](https://github.com/Koronaa/Corona/commit/0ef8bd73ebd1f3c02abdf05ec5ada10bf803e535))
* [RxSwift](https://github.com/ReactiveX/RxSwift)
* [RxCocoa](https://github.com/ReactiveX/RxSwift/tree/master/RxCocoa)
* [RxDataSources](https://github.com/RxSwiftCommunity/RxDataSources)
* [NotificationBannerSwift](https://github.com/Daltron/NotificationBanner)
* [Swinject](https://github.com/Swinject/Swinject)
* [SwinjectStoryboard](https://github.com/Swinject/SwinjectStoryboard)
* [SkeletonView](https://github.com/Juanpe/SkeletonView)

### Note:
I had to tweak [NotificationBannerSwift](https://github.com/Daltron/NotificationBanner) a little bit to avoid a crash. So if in case you do a `pod install` make sure to do the following change in BaseNotificationBanner.swift file,

```swift
/// The main window of the application which banner views are placed on
    private let appWindow: UIWindow? = {
        var window:UIWindow? = UIApplication.shared.keyWindow
        if window == nil{
            // Fetching window for iOS 13
            if #available(iOS 13.0, *) {
                window = UIApplication.shared.windows.filter({$0.windowScene?.activationState == .foregroundActive}).first!
            }
        }
        return window
    }()
    
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.


## License
[MIT](https://github.com/Koronaa/Corona/blob/master/LICENSE)
    



