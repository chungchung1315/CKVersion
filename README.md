# CKVersion
[![Version](https://img.shields.io/cocoapods/v/CKVersion.svg?style=flat)](https://cocoapods.org/pods/CKVersion)
[![License](https://img.shields.io/cocoapods/l/CKVersion.svg?style=flat)](https://cocoapods.org/pods/CKVersion)
[![Platform](https://img.shields.io/cocoapods/p/CKVersion.svg?style=flat)](https://cocoapods.org/pods/CKVersion)
[![SwiftPM](https://img.shields.io/badge/SPM-supported-DE5C43.svg?style=flat)](https://swift.org/package-manager/)

## Usage

This library provides a version object for semantic versioning which is formatted with "MAJOR.MINOR.PATCH".

It supports only numbers and dots(e.g. "1.0.0"). Not supporting release state like "-beta" suffix.

### Compare versions

```swift
let version1 = Version(1, 0, 0) // init from numbers
let version2 = try! Version.from(string: "1.1.0") // init from string

if version1 < version2 { // compare versions
    print("\(version2.toString) is newer.") // 1.1.0 is newer.
}
```

### Fetch App Store version

```swift
// Using async/await
Task {
    let version = try await Version.fetchAppStoreVersion()
    print("App Store Version:", version.toString)
}

// Using completion handler
Version.fetchAppStoreVersion(bundleIdentifier: Bundle.main.bundleIdentifier!) { version, error in // If bundlerIdentifier is nil or omitted, the main bundle identifier is used.
    if let error { print(error) }
    print("App Store Version:", version.toString)
}
```

A fetchAppStoreVersion method uses App Store API, so the internet connection is needed.

## Requirements

iOS 11+

## Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/chungchung1315/CKVersion.git", .upToNextMajor(from: "0.2.0"))
]
```

### Cocoapods

CKVersion is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'CKVersion'
```

## Author

chungchung1315, chungchung1315@gmail.com

## License

CKVersion is available under the MIT license. See the LICENSE file for more info.
