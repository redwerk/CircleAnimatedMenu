# CircleAnimatedMenu

[![CocoaPods](https://img.shields.io/cocoapods/p/CircleMenu.svg)](https://cocoapods.org/pods/CircleMenu)
[![Version](https://img.shields.io/cocoapods/v/CircleAnimatedMenu.svg?style=flat)](http://cocoapods.org/pods/CircleAnimatedMenu)
[![License](https://img.shields.io/cocoapods/l/CircleMenu.svg?style=flat)](https://https://github.com/redwerk/CircleAnimatedMenu/blob/master/LICENSE)

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

4) Build array of tuples. Each tuple should contain two String values, first value - image name, second - category text. It can be written in func viewDidLoad.

```swift
testMenu.dataTuple = [("facebook", "Facebook"), ("insta", "Instagram"), ("twit", "Twitter"),
("link", "LinkedIn"), ("googlePlus", "GooglePlus"), ("github", "GitHub")];
```
5) Set delegate to get index and text selected section.
```swift
testMenu.delegate = self
```

##### Programmatically

```swift
let menuFrame = CGRect(x: 0, y: 0, width: 220, height: 220)
let testMenu = CircleAnimatedMenu(menuFrame: menuFrame, dataArray: [("facebook", "Facebook"), ("insta", "Instagram"), ("twit", "Twitter"), ("link", "LinkedIn"), ("googlePlus", "GooglePlus"), ("github", "GitHub")])
testMenu.delegate = self
self.view.addSubview(testMenu)
```

##### Delegate method

```swift
// to get text and index of selected section
func sectionSelected(text: String, index: Int)
```

##### Public properties

```swift
// Inner radius of menu
@IBInspectable public var innerRadius: CGFloat = 30

// Outer radius of menu
@IBInspectable public var outerRadius: CGFloat = 75

// Width of line between sections and central circle
@IBInspectable public var closerBorderWidth: CGFloat = 2

// Width of border menu
@IBInspectable public var farBorderWidth: CGFloat = 0 

// Menu fill color
@IBInspectable public var menuFillColor: UIColor = .darkGray

// Menu background color - color of layer that lies under section layers and inner circle layer
@IBInspectable public var menuBackgroundColor: UIColor = .white

// Inner circle color
@IBInspectable public var innerCircleColor: UIColor = .darkGray

// Color of section after selection
@IBInspectable public var highlightedColor: UIColor = .blue

// Color of line between slices and central circle
@IBInspectable public var closerBorderColor: UIColor = .white

// Border menu color
@IBInspectable public var farBorderColor: UIColor = .white

// Sections stroke color
@IBInspectable public var sectionsStrokeColor: UIColor = .white

// Text color
@IBInspectable public var textColor: UIColor = .white

// Shadow color
@IBInspectable public var shadowColor: UIColor = .lightGray 

// Shadow radius
@IBInspectable public var menuShadowRadius: CGFloat = 15

// Duration it takes to sections to expand.
public var animDuration: Double = 1.0

// Menu width line
@IBInspectable public var menuWidthLine: CGFloat = 0

// Text font size
@IBInspectable public var titleFontSize: CGFloat = 13

// Image size value
public var imageSize: CGFloat = 30

// Default highlighted section index. Set it if you want to highlight some section at start
@IBInspectable public var defaulHighlightedtSectionIndex: Int = -1 

// set animation state. Default - true
public var animated: Bool = true 

// Data
public var dataTuple: [(String, String)] = []

// You can set highlighted colors array if you want to highlight each section separately
public var highlightedColors: [UIColor] = []
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

![enter image description here](http://i.giphy.com/2cHVF6BulaiC4.gif)

## License

CircleAnimatedMenu is available under the MIT license. See the LICENSE file for more info.
