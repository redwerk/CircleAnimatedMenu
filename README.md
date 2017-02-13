# CircleAnimatedMenu

[![CocoaPods](https://img.shields.io/cocoapods/p/CircleMenu.svg)](https://cocoapods.org/pods/CircleMenu)
[![Version](https://img.shields.io/cocoapods/v/CircleAnimatedMenu.svg?style=flat)](http://cocoapods.org/pods/CircleAnimatedMenu)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

![enter image description here](http://i.giphy.com/116ySzTQHWiyCk.gif)

## Requirements

- iOS 9.0
- Xcode 8.0+

## Installation

CircleAnimatedMenu is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CircleAnimatedMenu"
```

## Usage

##### With storyboard

1) Create a new UIView inheriting from `CircleAnimatedMenu`

2) Create IBOutlet property in your view controller:
```swift
@IBOutlet weak var testMenu: CircleAnimatedMenu!
```
3) Connect IBOutlet with `CircleAnimatedMenu` in IB.

4) Build array of tuples. Each tuple should contain two String values, first value - image name, second - section text. It can be written in func viewDidLoad.

```swift
testMenu.dataTuple = [("facebook", "Facebook"), ("insta", "Instagram"), ("twit", "Twitter"),
                      ("link", "LinkedIn"), ("googlePlus", "GooglePlus"), ("github", "GitHub")];
```
5) Set delegate to get index and text of selected section.
```swift
testMenu.delegate = self
```



##### Programmatically

```swift
let menuFrame = CGRect(x: 0, y: 0, width: 220, height: 220)
let testMenu = CircleAnimatedMenu(menuFrame: menuFrame, dataArray: [("facebook", "Facebook"), ("insta", "Instagram"), ("twit", "Twitter"),
("link", "LinkedIn"), ("googlePlus", "GooglePlus"), ("github", "GitHub")])
testMenu.delegate = self
self.view.addSubview(testMenu)
```

##### Delegate method `CircleAnimatedMenuDelegate`

```swift
// to get text and index selected section
func sectionSelected(text: String, index: Int)
```

## License

CircleAnimatedMenu is available under the MIT license. See the LICENSE file for more info.
