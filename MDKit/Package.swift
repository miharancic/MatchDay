// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MDKit",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "MDDomain",
            targets: ["MDDomain"]
        ),
        .library(
            name: "MDData",
            targets: ["MDData"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/SDWebImage/SDWebImageSVGCoder.git", from: "1.8.0"),
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", from: "3.1.4")
    ],
    targets: [
        .target(
            name: "MDDomain",
            dependencies: [
                .byName(name: "MDUtils"),
                .byName(name: "SDWebImageSVGCoder"),
                .byName(name: "SDWebImageSwiftUI")
            ]
        ),
        .target(
            name: "MDData",
            dependencies: ["MDDomain"]
        ),
        .target(
            name: "MDUtils"
        ),
    ]
)
