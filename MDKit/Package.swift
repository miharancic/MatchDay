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
    targets: [
        .target(
            name: "MDDomain",
            dependencies: ["MDUtils"]
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
