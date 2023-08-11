// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "CKVersion",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "CKVersion", targets: ["CKVersion"])
    ],
    targets: [
        .target(name: "CKVersion", path: "CKVersion/Classes")
    ],
    swiftLanguageVersions: [
        .v5
    ]
)