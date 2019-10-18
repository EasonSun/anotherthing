//
//  StikLightAlgoTests.swift
//  StikLightAlgoTests
//
//  Created by Yicheng on 10/16/19.
//  Copyright © 2019 Yicheng Sun. All rights reserved.
//

import XCTest
@testable import StikLightAlgo

class StikLightAlgoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let data = ColorCube.readFromLUT(fileName: "/Users/Account/Drink/StikLightAlgo/StikLightAlgo/test_lut.txt", dimension: 33)
        
        let sampleImage = Bundle(for: StikLightAlgoTests.self).path(forResource: "IMG_4302", ofType: "jpg")
            .flatMap { URL(fileURLWithPath: $0) }
            .flatMap { try? Data(contentsOf: $0) }
            .flatMap { CIImage.init(data: $0) }
        
        let filter = CIFilter(name: "CIColorCube", parameters: [
            "inputCubeDimension":33,
            "inputCubeData": data,
            "inputImage":sampleImage
            ])
//        print(filter!.outputImage)
        
        let cgImage = CIContext(options: nil).createCGImage(filter!.outputImage!, from: filter!.outputImage!.extent)
        
        let result_image = UIImage(cgImage: cgImage!)
        
//        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        let fileURL = documentsURL.appendingPathComponent("result_image.jpg")
        let dir = FileManager.default.urls(for: .picturesDirectory, in: .userDomainMask)[0]
        let imageUrl = dir.appendingPathComponent("result_image.jpg", isDirectory: false)
        //
        if let imageData = result_image.jpegData(compressionQuality: 1.0) {
            try! imageData.write(to: imageUrl, options: .atomic)
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
