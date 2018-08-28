// swift-tools-version:4.2
import PackageDescription

let package = Package(
  name: "SwiftyTextTable",
     products: [
        .library(name: "SwiftyTextTable", targets: ["SwiftyTextTable"])
    ],
  targets: [
    .target(name: "SwiftyTextTable")
  ]
)
