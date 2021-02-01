// Telemetry.swift

// Copyright © 2021 Socii. All rights reserved.
// MIT License @ end of file.

import Foundation

// MARK: Definition

/// An iRacing telemetry object.
///
public struct Telemetry {
  
  /// Telemetry Header.
  private let header: Telemetry.Header
  
  /// IBT wrapper.
  private let ibt: IBT
  
  /// A dictionary containing all available telemetry channels.
  let channels: [String: Channel]
    
  /// Session Info.
  private let weekend: Weekend
  
  /// Telemetry start date.
  public let date: Date
  
  /// Attempt to create a `Telemetry` instance from a `URL`.
  ///
  /// - Parameter url: the URL of the telemetry.
  ///
  public init?(url: URL) {
    
    // Make sure we have a file and it
    // has an ".ibt" extension, else fail.
    guard url.isFileURL && url.pathExtension == "ibt" else {
      logln("\(url) is not an .ibt file.", level: .error)
      return nil
    }
    
    // Attempt to open the url as an IBT, else fail.
    guard let ibtinit = IBT.open(url: url)
      else { logln("Unable to create IBT from url: \(url).", level: .error)
      return nil
    }
    
    // Store the returned properties.
    header = ibtinit.header
    ibt = ibtinit.ibt
    weekend = ibtinit.weekend
    channels = ibtinit.channels
    
    // Create the session date from the url.
    let dateTime = url
      .deletingPathExtension()
      .absoluteString
      .suffix(19)
      .replacingOccurrences(of: "%20", with: ":")
    
    // Attempt to convert to a Date object, else fail.
    guard let date = DateFormatter.iRacing.date(from: dateTime) else {
      logln("Unable to get date from url.", level: .error)
      return nil
    }
    
    self.date = date
  }
}

// MARK: - Interface

public extension Telemetry {
  
  /// Returns a dictionary containing session information.
  var info: [String : String] {
    return weekend.info
  }
  
  /// Returns a dictionary containing session options.
  var options: [String : String] {
    return weekend.options
  }
  
  /// Returns a dictionary conataining driver information.
  var driver: [String : String] {
    
    // FIXME: Precondition failures may not be relevant.
    guard let value = weekend.driverInfo["DriverCarIdx"] else {
      preconditionFailure("Unable to get DriverCarIdx")
    }
        
    guard var idx = Int(value) else {
      preconditionFailure("Unable to convert \(value) to Int.")
    }
    
    // FIXME: Sometimes the DriverCarIdx exceeds the count
    //        of drivers. Quick fix below but not sure
    //        if this is correct.
    if idx > weekend.drivers.count {
      idx = weekend.drivers.count - 1
    }
    
    return weekend.drivers[idx]
  }
  
  /// Returns an array of dictionaries containing
  /// driver information.
  var drivers: [[String : String]] {
    return weekend.drivers
  }
  
  /// Returns the track name and configuration.
  var trackNameFull: String {
    var string = ""
    string.append("\(info["TrackDisplayName"]!)")
    if let config = info["TrackConfigName"], config != "" {
      string.append(" - \(config)")
    }
    return string
  }
  
  /// Returns the car name.
  var carName: String {
    return driver["CarScreenName"] ?? ""
  }
  
  /// Returns a telemetry channel with the given name.
  ///
  /// - Precondition: The name of the channel must match
  ///                 one of the iRacing channels.
  /// - Parameter named: The name of the channel to return.
  ///
  /// Use the `Channels` object to get the correct name of
  /// a channel:
  ///
  /// ```
  /// let c = channel(named: Channels.Suspension.RFshockDefl)
  /// ```
  ///
  func channel(named: String) -> Channel {
  
    // Precondition: Check the channel name
    // exists in the dictionary.
    guard var channel = channels[named] else {
      preconditionFailure("Channel \"\(named)\" does not exist.")
    }
    
    // Populate the samples.
    populate(channel: &channel)
    
    // Return the channel.
    return channel
  }
  
//  func channels(named strings: [String]) -> [Channel] {
//    
//    let notFound = strings.filter { channels[$0] == nil }
//    precondition(notFound.isEmpty, "Channels named \"\(notFound)\" do not exist.")
//    
//    // Precondition: Check the channel name
//    // exists in the dictionary.
//    var passed = true
//    var notFoundNames = [String]()
//    for name in strings {
//      if channels[name] == nil {
//        passed = false
//        notFoundNames.append(name)
//      }
//    }
//    
//    guard passed else {
//      preconditionFailure("Channels \"\(notFoundNames)\" do not exist.")
//    }
//    
//    return channels
//  }
  
  #if DEBUG
  var yaml: String {
    return weekend.yaml
  }
  #endif
}

// MARK: - Custom String Convertable

extension Telemetry: CustomStringConvertible {
  
  public var description: String {
       
    var string = ""
    string.append("\(DateFormatter.medium.string(from: date))\n")
    string.append("\(trackNameFull)\n")
    string.append("\(driver["CarScreenName"] ?? "")\n")
    string.append("\(driver["UserName"] ?? "")\n")
    return string
  }
}

// MARK: - Model

private extension Telemetry {
    
  /// Populates a `Channel` with sample data.
  ///
  /// - Parameter channel: The iRacing channel.
  ///
  private func populate(channel: inout Channel) {
    
    // Create an empty array.
    var samples = [IRacingDataTypeRepresentable]()
    
    // Set the cursor to the beginning
    // of the Channel data.
    var cursor = header.bufferOffset + channel.offset
    
    // Read from the IBT file.
    let dataType = channel.dataType
    let length = dataType.length
    var hasSample = true
    while hasSample == true {
      ibt.seek(toFileOffset: cursor)
      let data = ibt.readData(ofLength: length)
      if data.count != length {
        hasSample = false
      } else {
        samples.append(dataType.value(from: data))
        cursor += header.bufferLength
      }
    }
  
    // Add the sample data to the channel.
    channel.samples = samples
  }
  
  /// Populates multiple `Channels` with sample data.
  ///
  /// - Parameter channels: The iRacing channels.
  ///
//  private func populate(channels: inout [Channel]) {
//
//    let sorted = channels.sort { $0.offset < $1.offset }
//
//
//    // Create an empty array.
//    var samples = [IRacingDataTypeRepresentable]()
//
//    // Set the cursor to the beginning
//    // of the Channel data.
//    var cursor = header.bufferOffset + channel.offset
//
//    // Read from the IBT file.
//    let dataType = channel.dataType
//    let length = dataType.length
//    var hasSample = true
//    while hasSample == true {
//      ibt.seek(toFileOffset: cursor)
//      let data = ibt.readData(ofLength: length)
//      if data.count != length {
//        hasSample = false
//      } else {
//        samples.append(dataType.value(from: data))
//        cursor += header.bufferLength
//      }
//    }
//
//    // Add the sample data to the channel.
//    channel.samples = samples
//  }
}

private extension DateFormatter {
  
  static let iRacing: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yy-MM-dd:HH-mm-ss"
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    return formatter
  }()
  
  static let medium: DateFormatter = {
    let formatter = DateFormatter()
    formatter.calendar = .autoupdatingCurrent
    formatter.dateStyle = .medium
    return formatter
  }()
}

// MARK: - Header

extension Telemetry {

  /// The telemetry header struct.
  ///
  internal struct Header {
    
    /// The telemetry version.
    let version: Int32
    
    /// The telemetry status.
    let status: Int32

    /// The sample tick rate.
    let tickRate: Int32

    /// The update of the session info in the data sequence.
    let sessionInfoUpdate: Int32

    /// The length of the session info in the data sequence.
    let sessionInfoLength: Int
    
    /// The offset of the session info in the data sequence.
    let sessionInfoOffset: UInt64
    
    /// The number of available channels.
    let channelCount: Int32

    /// The offset of the channel headers in the data sequence.
    let channelHeaderOffset: UInt64
    
    /// The number of buffers.
    let bufferCount: Int32
    
    /// The length of the buffer.
    let bufferLength: UInt64

    /// Unused (padding?).
    let part1: Int32

    /// Unused (padding?).
    let part2: Int32
    
    /// Unused (padding?).
    let part3: Int32

    /// The offset of the buffer in the data sequence.
    let bufferOffset: UInt64
    
    /// Create a header from data.
    ///
    /// - Parameter data: The data block.
    ///
    init(data: Data) {
            
      // Populate the properties from the data object.
      version = data.slice(at: 0) as Int32
      
      status =  data.slice(at: 4) as Int32
      
      tickRate = data.slice(at: 8) as Int32
      
      sessionInfoUpdate = data.slice(at: 12) as Int32
      
      sessionInfoLength = Int(data.slice(at: 16) as Int32)
      
      sessionInfoOffset = UInt64(data.slice(at: 20) as Int32)
      
      channelCount = data.slice(at: 24) as Int32
      
      channelHeaderOffset = UInt64(data.slice(at: 28) as Int32)
      
      bufferCount = data.slice(at: 32) as Int32
      
      bufferLength = UInt64(data.slice(at: 36) as Int32)
      
      part1 = data.slice(at: 40) as Int32
      
      part2 = data.slice(at: 44) as Int32
      
      part3 = data.slice(at: 48) as Int32
      
      bufferOffset = UInt64(data.slice(at: 52) as Int32)
    }
  }
}

// MARK: - Model

extension Telemetry.Header {
  
  /// Length of the Telemetry Header in bytes.
  static let length = 112
}

// MIT License:

/*
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.

 IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
