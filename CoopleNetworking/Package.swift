// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "CoopleNetworking",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "CoopleNetworking",
            targets: ["CoopleNetworking"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CoopleNetworking",
            dependencies: []),
        .testTarget(
            name: "CoopleNetworkingTests",
            dependencies: ["CoopleNetworking"]),
    ]
)
