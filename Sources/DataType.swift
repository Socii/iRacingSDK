// DataType.swift

// Copyright © 2021 Socii. All rights reserved.
// MIT License @ end of file.

import Foundation

// MARK: Definition

/// An enum containing the data types used in
/// the iRacing IBT file.
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
  
  /// Returns an iRacing data type from data.
  ///
  /// - Parameter data: The data.
  ///
  func value(from data: Data) -> IRacingDataTypeRepresentable {
    
    switch self {
      
    // String.
    case .IRChar:
      if let s = String(data: data, encoding: .ascii) {
        return s
      } else {
        logln("Unable to convert Data to String")
        return ""
      }
      
    // Boolean.
    case .IRBool:
      if let b = Int8(data: data) {
        return b
      } else {
        logln("Unable to convert Data to Boolean")
        return 0
      }
      
    // Integer.
    case .IRInt:
      if let t = Int32(data: data) {
        return t
      } else {
        return 0
      }
      
    // Bit Field.
    case .IRBitfield:
      if let t = UInt32(data: data) {
        return t
      } else {
        return 0
      }
      
    // Float.
    case .IRFloat:
      if let t = Float(data: data) {
        return t
      } else {
        return 0
      }
      
    // Double.
    case .IRDouble:
      if let t = Double(data: data) {
        return t
      } else {
        return 0
      }
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

public protocol IRacingDataTypeRepresentable { }

extension String: IRacingDataTypeRepresentable { }
extension Int8: IRacingDataTypeRepresentable { }
extension Int32: IRacingDataTypeRepresentable { }
extension UInt32: IRacingDataTypeRepresentable { }
extension Float: IRacingDataTypeRepresentable { }
extension Double: IRacingDataTypeRepresentable { }

// MIT License:

/*
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.

 IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
