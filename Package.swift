// swift-tools-version:5.0
//
//  Package.swift
//  Arcade
//
//  Created by Aaron Wright on 5/1/18.
//  Copyright © 2018 Aaron Wright. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "JWT",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v10),
        .tvOS(.v10),
        .watchOS(.v3)
    ],
    products: [
        .library(
            name: "JWT",
            targets: ["JWT"])
    ],
    targets: [
        .target(
            name: "JWT",
            path: "Sources"),
        .testTarget(
            name: "JWTTests",
            dependencies: ["JWT"],
            path: "Tests"),
    ],
    swiftLanguageVersions: [.v5]
)

