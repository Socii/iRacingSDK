// SamplesTests.swift

// Copyright © 2021 Socii. All rights reserved.
// MIT License @ end of file.

import XCTest
@testable import iRacingSDK

class SamplesTests: XCTestCase {

  var telemetry: Telemetry!
  var LFpres: Channel!
  var RFpres: Channel!
  var LRpres: Channel!
  var RRpres: Channel!
  
  override func setUp() {
    
    let url = URL(fileURLWithPath: "/Volumes/Work/4LD/4LD Motorsport/Telemetry/radical sr8_oulton intnochicane 2016-02-10 19-54-52.ibt")

    telemetry = Telemetry(url: url)
    LFpres = telemetry.channel(named: Tyres.LFpressure)
    RFpres = telemetry.channel(named: Tyres.RFpressure)
    LRpres = telemetry.channel(named: Tyres.LRpressure)
    RRpres = telemetry.channel(named: Tyres.RRpressure)
  }

  override func tearDown() {
    telemetry = nil
  }
}

extension SamplesTests {
  
  func testMultiChannelsEqualToSingleChannels() {
    
    let channels = telemetry.channels(named: [Tyres.LFpressure, Tyres.LRpressure, Tyres.RFpressure, Tyres.RRpressure])

    XCTAssertEqual(LFpres.samples as! [Float], channels[Tyres.LFpressure]!.samples as! [Float])
    XCTAssertEqual(RFpres.samples as! [Float], channels[Tyres.RFpressure]!.samples as! [Float])
    XCTAssertEqual(LRpres.samples as! [Float], channels[Tyres.LRpressure]!.samples as! [Float])
    XCTAssertEqual(RRpres.samples as! [Float], channels[Tyres.RRpressure]!.samples as! [Float])
  }
}
