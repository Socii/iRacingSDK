// PerformanceTests.swift

// Copyright © 2021 Socii. All rights reserved.
// MIT License @ end of file.

import XCTest
@testable import iRacingSDK

class PerformanceTests: XCTestCase {
  
  var telemetry: Telemetry!
  
  override func setUp() {
    let url = URL(fileURLWithPath: "/Volumes/Work/4LD/4LD Motorsport/Telemetry/radical sr8_oulton intnochicane 2016-02-10 19-54-52.ibt")

    telemetry = Telemetry(url: url)
    
  }

  override func tearDown() {
    telemetry = nil
  }
}

extension PerformanceTests {
  
  func testChannelLoad() {
    self.measure {
      let channel = telemetry.channel(named: PitCrew.PitSvFlags)
    }
  }
}
