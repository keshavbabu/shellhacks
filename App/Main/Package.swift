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
    dependencies: [
        .package(
            url: "https://github.com/firebase/firebase-ios-sdk",
            .upToNextMajor(from: "11.20.0")
        ),
    ],
    targets: [
        .target(
            name: "Main",
            dependencies: [
                .product(
                    name: "FirebaseFirestore",
                    package: "firebase-ios-sdk"
                ),
            ]
        )
    ]
)
