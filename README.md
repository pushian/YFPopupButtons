# YFPopupButtons

[![CI Status](http://img.shields.io/travis/pushian/YFPopupButtons.svg?style=flat)](https://travis-ci.org/pushian/YFPopupButtons)
[![Version](https://img.shields.io/cocoapods/v/YFPopupButtons.svg?style=flat)](http://cocoapods.org/pods/YFPopupButtons)
[![License](https://img.shields.io/cocoapods/l/YFPopupButtons.svg?style=flat)](http://cocoapods.org/pods/YFPopupButtons)
[![Platform](https://img.shields.io/cocoapods/p/YFPopupButtons.svg?style=flat)](http://cocoapods.org/pods/YFPopupButtons)

![Demo Gif](Screenshot/demo.gif)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

YFPopupButtons is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "YFPopupButtons"
```

##How To Use

##Initialization
```swift
var testView = YFPopupButtonsView()
testView.delegate = self
```
###Core Functions
- Display the button view and pop up the buttons.
```swift
    testView.show()
```
- Dismiss the button view and the buttons. Normally, the user does not have to call this function in their own code because there is alreay built in dismiss actions in the view.
```swift
testView.dismiss()
```

###Delegate Functions
- func numOfItems(buttonsView: YFPopupButtonsView) -> Int
- func maxNumberOfItemsInRow(buttonsView: YFPopupButtonsView) -> Int
- func itemSize(buttonsView: YFPopupButtonsView) -> CGSize
- func buttonsView(buttonsView: YFPopupButtonsView, itemForIndex index: Int) -> YFPopupbotton
- func buttonsView(buttonsView: YFPopupButtonsView, didTapItemAtIndex index: Int)
- optional func sideMargin(buttonsView: YFPopupButtonsView) -> CGFloat
- optional func spaceBetweenRows(buttonsView: YFPopupButtonsView) -> CGFloat
- optional func buttonsViewWillDisappear(buttonsView: YFPopupButtonsView)
- optional func buttonsViewWillAppear(buttonsView: YFPopupButtonsView)

## Author

pushian, l@fooyo.sg

## License

YFPopupButtons is available under the MIT license. See the LICENSE file for more info.
