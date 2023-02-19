// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "BitcoinKit",
    platforms: [
        .macOS(.v12),
    ],
    products: [
        .library(
            name: "BitcoinKit",
            targets: ["BitcoinKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/BoRoZzz/BitcoinCore.git", .upToNextMinor(from: "1.0.0")),
        .package(url: "https://github.com/BoRoZzz/HdWalletKit.git", .upToNextMinor(from: "1.0.0")),
        .package(url: "https://github.com/BoRoZzz/Hodler.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/BoRoZzz/HsToolKit.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/BoRoZzz/HsCryptoKit.git", .upToNextMinor(from: "1.0.0")),
        .package(url: "https://github.com/BoRoZzz/HsExtensions.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/attaswift/BigInt.git", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "5.0.1")),
        .package(url: "https://github.com/groue/GRDB.swift.git", .upToNextMajor(from: "5.0.0")),
    ],
    targets: [
        .target(
            name: "BitcoinKit",
            dependencies: [
                "BigInt", "RxSwift",
                .product(name: "BitcoinCore", package: "BitcoinCore"),
                .product(name: "Hodler", package: "Hodler"),
                .product(name: "HsCryptoKit", package: "HsCryptoKit"),
                .product(name: "HsExtensions", package: "HsExtensions"),
                .product(name: "HsToolKit", package: "HsToolKit"),
                .product(name: "HdWalletKit", package: "HdWalletKit"),
                .product(name: "GRDB", package: "GRDB.swift")
            ]
        ),
    ]
)
