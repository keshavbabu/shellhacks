// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Main",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "Main",
            targets: ["Main"]
        ),
    ],
    targets: [
        .target(
            name: "Main"
        )
    ]
)
