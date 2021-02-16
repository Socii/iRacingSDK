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
    
  /// Weekend Info.
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
  
  /// Returns a dictionary containing weekend information.
  var info: [String : String] {
    return weekend.info
  }
  
  /// Returns a dictionary containing weekend options.
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
  /// - Parameter named: The name of the channel to return.
  /// - Precondition: The name of the channel must match
  ///                 one of the iRacing channels.
  ///
  /// Correct channel name strings are stored in the
  /// following objects:
  /// + Tyres
  /// + Suspension
  /// + Brakes
  /// + Engine
  /// + Session
  /// + Laps
  /// + Input
  /// + Weather
  /// + Vehicle
  /// + PitCrew
  /// + Sim
  /// + Player
  /// + InCar
  ///
  /// Example:
  /// ```
  /// let c = channel(named: Suspension.RFshockDefl)
  /// ```
  ///
  func channel(named: String) -> Channel {
  
    // Precondition: Check the channel name
    // exists in the dictionary.
    guard var channel = channels[named] else {
      preconditionFailure("Channel \"\(named)\" does not exist.")
    }
    
    // Populate the samples and return.
    populate(channel: &channel)
    return channel
  }
  
  /// Returns a dictionary containing telemetry channels.
  ///
  /// - Parameter names: The name(s) of the channel(s).
  /// - Precondition: The name(s) of the channel(s) must match
  ///                 one of the iRacing channels.
  ///
  /// Correct channel name strings are stored in the
  /// following `Enums`:
  /// + Tyres
  /// + Suspension
  /// + Brakes
  /// + Engine
  /// + Session
  /// + Laps
  /// + Input
  /// + Weather
  /// + Vehicle
  /// + PitCrew
  /// + Sim
  /// + Player
  /// + InCar
  ///
  /// Example:
  /// ```
  /// let c = channels(named: [Tyres.LFpressure,
  ///                          Tyres.LRpressure,
  ///                          Tyres.RFpressure,
  ///                          Tyres.RRpressure])
  /// ```
  ///
  func channels(named names: [String]) -> [String : Channel] {
    
    /// Precondition check.
    let notFound = names.filter { channels[$0] == nil }
    precondition(notFound.isEmpty, "Channel(s) named \"\(notFound)\" do not exist.")
    
    // Populate the requested Channels with sample data.
    let selected = channels.filter { names.contains($0.key) }
    var channelArray = Array(selected.values)
    populate(channels: &channelArray)
    return selected
  }
  
  #if DEBUG
  var yaml: String {
    return weekend.yaml
  }
  
  var _channels: [String : Channel] {
    return channels
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
        channel.samples.append(dataType.converted(from: data))
        cursor += header.bufferLength
      }
    }
  }
  
  /// Populates multiple `Channels` with sample data.
  ///
  /// - Parameter channels: The iRacing channels.
  ///
  private func populate(channels: inout [Channel]) {

    // Sort the channels in order of their offset
    // in the data sequence.
    let sorted = channels.sorted { $0.offset < $1.offset }

    // Set the cursor to the beginning
    // of the Channel data.
    var cursor = header.bufferOffset

    // Read from the IBT file.
    var hasSample = true
    while hasSample == true {
      for channel in sorted {
        let offset = cursor + channel.offset
        let dataType = channel.dataType
        let length = dataType.length
        ibt.seek(toFileOffset: offset)
        let data = ibt.readData(ofLength: length)
        if data.count != length {
          hasSample = false
        } else {
          channel.samples.append(dataType.converted(from: data))
        }
      }
      cursor += header.bufferLength
    }
  }
}

private extension DateFormatter {
  
  /// The date format used in the IBT filename.
  static let iRacing: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yy-MM-dd:HH-mm-ss"
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    return formatter
  }()
  
  /// The date format used in the `description` property.
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
    /// - Precondition: The data size must be 112 bytes.
    ///
    init(data: Data) {
      
      // Precondition check.
      precondition(data.count == Header.length)
      
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
