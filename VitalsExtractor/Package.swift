// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "VitalsExtractor",
    platforms: [
        .iOS(.v15), .macOS(.v12)
    ],
    products: [
        .library(name: "VitalsExtractor", targets: ["VitalsExtractor"])    
    ],
    targets: [
        .target(
            name: "VitalsExtractor",
            resources: [
                // Place optional compiled CoreML model here if you want to bundle it in tests/apps using SPM resources.
                // .process("Resources/VitalsNER.mlmodelc")
            ]
        ),
        .testTarget(name: "VitalsExtractorTests", dependencies: ["VitalsExtractor"])    
    ]
)
