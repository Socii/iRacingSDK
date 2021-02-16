// Channel.swift

// Copyright © 2021 Socii. All rights reserved.
// MIT License @ end of file.

import Foundation

// MARK: Definition

/// An object representing an iRacing telemetry channel.
///
public class Channel {
  
  /// The channel header.
  private let header: Channel.Header
  
  /// Channel samples.
  public var samples = [IRacingDataTypeConvertable]()
  
  /// Creates a new `Channel` from a header.
  ///
  /// - Parameter header: The channel header
  ///
  init(header: Channel.Header) {
    self.header = header
  }
}

// MARK: - Interface

extension Channel {
  
  /// Returns the name of the channel.
  public var name: String {
    return header.name
  }
  
  /// Returns the measurement unit of the channel.
  public var unit: String {
    return header.unit
  }
  
  /// Returns the data type of the channel.
  var dataType: IRacingDataType {
    return header.dataType
  }

  /// Returns the offset of the channel.
  var offset: UInt64 {
    return header.offset
  }
}

// MARK: - Custom String Convertable

extension Channel: CustomStringConvertible {
  
  public var description: String {
    return "\(header.description) (\(unit)) : \(dataType)"
  }
}

// MARK: - Equatable

//extension Channel: Equatable {
//  public static func == (lhs: Channel, rhs: Channel) -> Bool {
//    return lhs.name == rhs.name &&
//    lhs.dataType == rhs.dataType &&
//    lhs.samples as? [IRacingDataTypeConvertable.Self] == rhs.samples as? [IRacingDataTypeConvertable.Type]
//  }
//}

// MARK: - Header

extension Channel {
  
  /// An object representing an iRacing telemetry channel header.
  ///
  struct Header {

    /// Channel data type.
    let dataType: IRacingDataType
    
    /// Channel name.
    let name: String
    
    /// Channel description.
    let description: String
    
    /// Channel unit.
    let unit: String
    
    /// Channel offset.
    let offset: UInt64
    
    /// Channel count.
    let count: Int32
    
    /// Channel frequency.
    let countAsTime: Int8
    
    /// Creates a new Channel instance from a data sequence.
    ///
    /// - Parameter data: The data used to create the channel.
    /// - Precondition: The size of `data` must be 144 bytes.
    ///
    init(data: Data) {
      
      /// Precondition check.
      precondition(data.count == Header.length)
      
      // Get the Channel type.
      let type = data.slice(at: 0) as Int32
      
      // Populate properties from the data.
      dataType = IRacingDataType(rawValue: type)!
      offset = UInt64(data.slice(at: 4) as Int32)
      count = data.slice(at: 8) as Int32
      countAsTime = data.slice(at: 12) as Int8
      name = String(data: data[16..<48],
                    encoding: .ascii)?
        .replacingOccurrences(of: "\0", with: "") ?? ""
      description = String(data: data[48..<112],
                           encoding: .ascii)?
        .replacingOccurrences(of: "\0", with: "")
        .replacingOccurrences(of: "  ", with: ", ") ?? ""
      unit = String(data: data[112..<144],
                    encoding: .ascii)?
        .replacingOccurrences(of: "\0", with: "") ?? ""
    }
  }
}

// MARK: - Model

extension Channel.Header {
  
  /// Length of the Channel Header in bytes.
  static let length = 144
}

// MIT License:

/*
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.

 IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
