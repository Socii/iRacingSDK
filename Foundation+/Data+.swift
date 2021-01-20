// Data+.swift

// Copyright © 2021 Socii. All rights reserved.
// MIT License @ end of file.

import Foundation

// MARK: Data extension

extension Data {
  
  /// Returns a slice of data, with the length being
  /// deterimined by the type of fixed width integer used.
  ///
  /// - Parameter index: The start index in the `Data` structure.
  ///
  func slice<T: FixedWidthInteger>(at index: Data.Index) -> T {
    
    let number: T = subdata(in: index..<index + MemoryLayout<T>.size).withUnsafeBytes( { $0.pointee } )
    
    return number.littleEndian
  }
}

// MARK: - Data Convertable Protocol

// Protocol to allow conversion of Data to Type.
// https://stackoverflow.com/questions/38023838/round-trip-swift-number-types-to-from-data

protocol DataConvertible {
  init?(data: Data)
  var data: Data { get }
}

extension DataConvertible {
  
  /// Attempt to create a value from a data sequence.
  ///
  /// - Parameter data: The data sequence.
  ///
  init?(data: Data) {
    
    guard data.count == MemoryLayout<Self>.size
      else { return nil }
    
    self = data.withUnsafeBytes { $0.pointee }
  }
  
  /// Returns a data representation of the value.
  var data: Data {
    var value = self
    return Data(buffer: UnsafeBufferPointer(start: &value, count: 1))
  }
}

extension Int8: DataConvertible { }
extension Int32: DataConvertible { }
extension UInt32: DataConvertible { }
extension Float: DataConvertible { }
extension Double: DataConvertible { }

// MARK: - Byte Count Formatter

extension ByteCountFormatter {
  
  static let mb: ByteCountFormatter = {
    let formatter = ByteCountFormatter()
    formatter.allowedUnits = [.useMB, .useBytes]
    formatter.countStyle = .memory
    return formatter
  }()
}

// MIT License:

/*
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.

 IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
