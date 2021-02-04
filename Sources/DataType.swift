// DataType.swift

// Copyright © 2021 Socii. All rights reserved.
// MIT License @ end of file.

import Foundation

// MARK: Definition

/// An enum containing the data types used in
/// an iRacing IBT file.
///
enum IRacingDataType: Int32 {
    
  case IRChar
  case IRBool
  case IRInt
  case IRBitfield
  case IRFloat
  case IRDouble
  
  /// Returns the length of the data type in bytes.
  var length: Int {
    switch self {
    case .IRChar, .IRBool: return 1
    case .IRInt, .IRBitfield, .IRFloat: return 4
    case .IRDouble: return 8
    }
  }
  
  /// Returns a Swift type converted from
  /// iRacing data.
  ///
  /// - Parameter data: The data.
  ///
  func converted(from data: Data) -> IRacingDataTypeConvertable {
    switch self {
    case .IRChar: return String(irdata: data)
    case .IRBool: return Bool(irdata: data)
    case .IRInt: return Int32(irdata: data)
    case .IRBitfield: return UInt32(irdata: data)
    case .IRFloat: return Float(irdata: data)
    case .IRDouble: return Double(irdata: data)
    }
  }
}

// MARK: - Custom String Convertable

extension IRacingDataType: CustomStringConvertible {
  
  public var description: String {
    switch self {
    case .IRChar: return "Character"
    case .IRBool: return "Boolean"
    case .IRInt: return "Integer"
    case .IRBitfield: return "Bit Field"
    case .IRFloat: return "Float"
    case .IRDouble: return "Double"
    }
  }
}

// MARK: - Protocol

public protocol IRacingDataTypeConvertable {
  init(irdata data: Data)
}

// MARK: - Swift Types Protocol Conformance

extension String: IRacingDataTypeConvertable {
  
  public init(irdata data: Data) {
    guard let value = String(data: data, encoding: .ascii)
      else { preconditionFailure("Unable to create String from Data.")}
    self = value
  }
}

extension Bool: IRacingDataTypeConvertable {
  
  public init(irdata data: Data) {
    guard let value = Int8(data: data) else {
      preconditionFailure("Unable to convert Data to Int8.")
    }
    switch value {
    case 0: self = false
    case 1: self = true
    default: preconditionFailure("Default case in switch statement reached.")
    }
  }
}

extension Int32: IRacingDataTypeConvertable {
  
  public init(irdata data: Data) {
    guard let value = Int32(data: data) else {
      preconditionFailure("Unable to convert Data to Int32.")
    }
    self = value
  }
}

extension UInt32: IRacingDataTypeConvertable {
  
  public init(irdata data: Data) {
    guard let value = UInt32(data: data) else {
      preconditionFailure("Unable to convert Data to UInt32.")
    }
    self = value
  }
}

extension Float: IRacingDataTypeConvertable {
  
  public init(irdata data: Data) {
    guard let value = Float(data: data) else {
      preconditionFailure("Unable to convert Data to Float.")
    }
    self = value
  }
}

extension Double: IRacingDataTypeConvertable {
  
  public init(irdata data: Data) {
    guard let value = Double(data: data) else {
      preconditionFailure("Unable to convert Data to Double.")
    }
    self = value
  }
}

// MIT License:

/*
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.

 IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
