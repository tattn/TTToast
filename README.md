# TTToast

A simple toast library written by Swift

<a target="_blank" href="https://raw.githubusercontent.com/tattn/TTToast/assets/tttoast.gif">
<img width="30%" height="30%" alt="TTToast" src="https://raw.githubusercontent.com/tattn/TTToast/assets/tttoast.gif"></a>

## Installation

### CocoaPods
Install with CocoaPods by adding the following to your Podfile:
```ruby
platform :ios, '8.0'
pod 'TTToast'
```

### Manually
Add manually:

1. Add TTToast.swift to your project.
2. Link QuartzCore.

## Examples

```swift
// simple
Toast.show(self.view, message: "Hello world\nToast test")

// customization
Toast.show(self.view, message: "Hello world\nToast test") {(config) in
    // appearance
    config.maxWidth = CGFloat(0.8)
    config.paddingHorizontal = CGFloat(10.0)
    config.paddingVertical = CGFloat(10.0)
    config.cornerRadius = CGFloat(8)
    config.alpha = CGFloat(0.5)
    config.font = UIFont(name: "SnellRoundhand", size: 25.0)
    config.textColor = UIColor(red: 0.192, green: 0.216, blue: 0.082, alpha: 1.0)
    config.backgroundColor = UIColor(red: 0.886, green: 0.976, blue: 0.72, alpha: 1.0)
    // shadow
    config.shadow = true
    config.shadowOpacity = Float(0.5)
    config.shadowRadius = CGFloat(10.0)
    config.shadowOffset = CGSizeMake(4.0, 4.0)
    config.shadowColor = UIColor(red: 0.576, green: 0.624, blue: 0.36, alpha: 1.0).CGColor
    // duration
    config.durationBefore = 1.0
    config.duration = 2.0
    config.durationAfter = 0.5
    // position
    config.position = Toast.Position.Bottom.rawValue | Toast.Position.Right.rawValue
}

// global settings
Toast.config.backgroundColor = UIColor.blackColor()
Toast.config.textColor = UIColor.whiteColor()
```


## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## License

TTToast is released under the MIT license. See LICENSE for details.
