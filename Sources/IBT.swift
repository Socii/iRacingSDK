// IBT.swift

// Copyright © 2021 Socii. All rights reserved.
// MIT License @ end of file.

import Foundation

// MARK: Definition

/// A wrapper class encapuslating an iRacing IBT file.
///
class IBT {
  
  /// The file handle for the .ibt file.
  let fileHandle: FileHandle
  
  /// The IBT header.
  let header: IBT.Header
  
  /// Creates a new instance from a header and file handle.
  /// Init is private. New instances are created via
  /// the IBT.open static function.
  ///
  /// - Parameters:
  ///   - header: The IBT Header
  ///   - fileHandle: The file handle for the .ibt file.
  ///
  private init(header: IBT.Header, fileHandle: FileHandle) {

    self.header = header
    self.fileHandle = fileHandle
  }
  
  /// *** Unsuported ***
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit {
    
    // Close the file when the instance goes out of scope
    fileHandle.closeFile()
  }
}

// MARK: - Interface

extension IBT {
  
  /// Reads a section of data from the `.ibt` file.
  ///
  /// - Parameter length: The number of bytes to read.
  ///
  func readData(ofLength length: Int) -> Data {
    return fileHandle.readData(ofLength: length)
  }
  
  /// Synchronously reads the available data up to
  /// the end of file or maximum number of bytes.
  ///
  func readDataToEndOfFile() -> Data {
    return fileHandle.readDataToEndOfFile()
  }
  
  /// Moves the file pointer to the specified offset
  /// within the `.ibt` file.
  ///
  /// - Parameter offset: The offset to seek to.
  ///
  func seek(toFileOffset offset: UInt64) {
    fileHandle.seek(toFileOffset: offset)
  }
}

// MARK: - Model

extension IBT {

  /// A tuple containing all objects required to create
  /// a `Telemetry` instance.
  ///
  typealias IBTinit = (header: Telemetry.Header,
                       ibt: IBT,
                       weekend: Weekend,
                       channels: [String: Channel])
  
  /// Attempt to open an iRacing IBT file from a `URL`.
  ///
  /// - Parameter url: The URL to open.
  /// - Returns: An `IBTinit` tuple if succesful,
  ///            otherwise returns `nil`.
  ///
  static func open(url: URL) -> IBTinit? {
    
    // Make sure we can open a file handle for reading,
    // else fail.
    guard let fileHandle = FileHandle(forReadingAtPath: url.path) else {
      logln("Unable to create a file handle for \(url)", level: .error)
      return nil
    }
    
    // Read the Telemetry Header from the file first...
    var data = fileHandle.readData(ofLength: Telemetry.Header.length)
    let telemetryHeader = Telemetry.Header(data: data)
    
    // ...followed by the Disk Header...
    data = fileHandle.readData(ofLength: IBT.Header.length)
    let ibtHeader = IBT.Header(data: data)
    
    // Create a new IBT instance.
    let ibt = IBT(header: ibtHeader, fileHandle: fileHandle)
    
    // Read the session data using the offset and length
    // provided in the telemetry header.
    fileHandle.seek(toFileOffset: telemetryHeader.sessionInfoOffset)
    data = fileHandle.readData(ofLength: telemetryHeader.sessionInfoLength)
    
    // Convert the data block to an ascii string for
    // the yaml parser, else fail.
    guard var yamlString = String(data: data, encoding: .ascii) else {
      logln("Unable to convert Data to ascii.", level: .error)
      return nil
    }
    
    // Check the ascii string is a valid YAML document,
    // else fail.
    if YAML.isValidYaml(input: yamlString) == false {
      logln("Yaml string is not a valid YAML document.", level: .error)
      return nil
    }
    
    // Attempt to create the Weekend struct from
    // the YAML string, else fail.
    guard let weekend = Weekend(yaml: &yamlString) else {
      logln("Unable to create weekend.", level: .error)
      return nil
    }
    
    // Populate the channels dictionary.
    fileHandle.seek(toFileOffset: telemetryHeader.channelHeaderOffset)
    var channels: [String: Channel] = [:]
    var total = 0
    for _ in 1...telemetryHeader.channelCount {
      data = fileHandle.readData(ofLength: Channel.Header.length)
      let header = Channel.Header(data: data)
      let channel = Channel(header: header)
      channels.updateValue(channel, forKey: header.name)
      total += header.dataType.length
    }
    
    // Return.
    return (telemetryHeader, ibt, weekend, channels)
  }
}

// MARK: - IBT Header

extension IBT {
  
  /// An IBT Header object.
  ///
  struct Header {
    
    /// The start date of the IBT session.
    let startDate: Double
    
    /// The start time of the IBT session.
    let startTime: Double
    
    /// The end time of the IBT session.
    let endTime: Double
    
    /// The number of laps completed in the IBT session.
    let lapCount: Int32
    
    /// The number of records in the IBT session.
    let recordCount: Int32

    /// Create a `Header` from `Data`.
    ///
    /// - Parameter data: The data sequence used to
    ///                   create the header.
    ///   The size of the data sequence must be 32 bytes.
    ///
    /// - Precondition: The data length must be 32 bytes.
    ///
    init(data: Data) {
      
      /// Precondition check.
      precondition(data.count == Header.length)
      
      // Populate the properties.
      startDate = Double(data.slice(at: 0) as Int32)
      startTime = Double(data.slice(at: 8) as Int32)
      endTime = Double(data.slice(at: 16) as Int32)
      lapCount = data.slice(at: 24) as Int32
      recordCount = data.slice(at: 28) as Int32
    }
  }
}

// MARK: - IBT Header Model

extension IBT.Header {
  
  /// The length of the IBT header in bytes.
  static let length = 32
}

// MIT License:

/*
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.

 IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
