// Weekend.swift

// Copyright © 2021 Socii. All rights reserved.
// MIT License @ end of file.

import Foundation

// MARK: Definition

/// An object containing the telemetry session information.
///
struct Weekend {
  
  let yaml: String
  
  /// Weekend information.
  let info: [String : String]
  
  /// Weekend options.
  let options: [String : String]
  
  /// Telemetry options.
  let telemetryOptions: [String : String]
  
  /// Driver information.
  let driverInfo: [String : String]
  
  /// Drivers.
  let drivers: [[String : String]]
  
  /// Attempt to create a `Weekend` instance from
  /// a YAML string.
  ///
  /// - Parameter yaml: The YAML string.
  ///
  init?(yaml: inout String) {
    
  do {
    
    self.yaml = yaml
    
    info = try Weekend.getDictionary(&yaml, start: "WeekendInfo:", end: "WeekendOptions:")
    
    options = try Weekend.getDictionary(&yaml, start: "WeekendOptions:", end: "TelemetryOptions:")
  
    telemetryOptions = try Weekend.getDictionary(&yaml, start: "TelemetryOptions:", end: "SessionInfo:")
    
    try Weekend.delete(&yaml, upto: "DriverInfo:")
    
    driverInfo = try Weekend.getDictionary(&yaml, start: "DriverInfo:", end: "Drivers:")
    
    drivers = try Weekend.getList(&yaml, start: "Drivers:\n", end: "SplitTimeInfo:")
    
//    for driver in drivers {
//      for item in driver {
//        logln("key: \(item.key), value: \(item.value)")
//      }
//    }
    
  } catch {
    logln(error, level: .error)
    return nil
    }
  }
}

// MARK: - Interface

extension Weekend {

}

// MARK: - Model

private extension Weekend {
  
  /// Returns an array of string dictionaries from
  /// an input string.
  ///
  /// - Parameters:
  ///   - input: The input string.
  ///   - start: A string specifying the start of the list.
  ///   - end: A string specifying the end of the list.
  ///
  /// - Requires: The `start` and `end` strings must be
  ///             found in the `input` string.
  ///
  static func getList(_ input: inout String, start: String, end: String) throws -> [[String : String]] {
    
    /// Get the indexes of the `start` and `end` strings.
    guard let start = input.index(after: start) else { throw YAMLError.unableToGetIndex }
    guard let end = input.index(of: end) else { throw YAMLError.unableToGetIndex }
    
    /// Get the sub-string between the `start` and
    /// `end` indexes, replacing the YAML `-` list
    /// identifiers.
    let string = String(input[start..<end])
      .replacingOccurrences(of: " - ", with: "")
      .replacingOccurrences(of: "   ", with: "")

    /// Create a new dictionary.
    var list = [[String : String]]()
    
    /// Get the indices of each car, else return.
    let indices = string.indices(of: "CarIdx:")
    guard !indices.isEmpty else { return list }
    
    /// Iterate through the indices array.
    for index in 0..<indices.count {
      
      /// Get the start and end idexes.
      let startIndex = String.Index(utf16Offset: indices[index],
                                    in: string)
      var endIndex = startIndex
      if index == indices.count - 1 {
        endIndex = string.endIndex
      } else {
        endIndex = String.Index(utf16Offset: indices[index + 1] - 1,
                                in: string)
      }
      
      /// Convert the sub-string to a dictionary,
      /// and append.
      let block = String(string[startIndex..<endIndex])
      let dict = try YAML.toDictionary(block)
      list.append(dict)
    }
        
    return list
  }
  
  /// Returns a string dictionary from an input string.
  ///
  /// - Parameters:
  ///   - input: The input string.
  ///   - start: The start of the string.
  ///   - end: The end of the string.
  ///
  /// - Requires: The `start` and `end` strings must
  ///             be found in the input string.
  ///
  /// This method removes the section of the `input`
  /// string between the `start` and `end` strings.
  ///
  static func getDictionary(_ input: inout String, start: String, end: String) throws -> [String : String] {
    
    /// Get the indexes of the `start` and `end` strings.
    guard let start = input.index(after: start) else { throw YAMLError.unableToGetIndex }
    guard let end = input.index(of: end) else { throw YAMLError.unableToGetIndex }
    
    /// Convert the string sub-range to a string
    /// dictionary, then delete.
    let string = String(input[start..<end])
    let block = try YAML.toDictionary(string)
    input.removeSubrange(input.startIndex..<end)
        
    return block
  }
  
  /// Deletes a section of an input string, up to
  /// a given search string.
  ///
  /// - Parameters:
  ///   - input: The input string.
  ///   - upto: The search string.
  ///
  /// - Requires: The search string must be found in
  ///             the input string.
  ///
  static func delete(_ input: inout String, upto: String) throws {
    
    /// Get the index of the `upto` string.
    guard let end = input.index(of: upto) else { throw YAMLError.unableToGetIndex }
    
    /// Remove.
    input.removeSubrange(input.startIndex..<end)
  }
}

private extension String {
  
  /// Returns an array of integers specifying
  /// the position(s) of a string within the string.
  ///
  /// - Parameter of: The string to search for.
  ///
  func indices(of occurrence: String) -> [Int] {
    
    var indices = [Int]()
    var position = startIndex
    
    /// Iterate through the String, searching for
    /// the next occurence.
    while let range = range(of: occurrence,
                            range: position..<endIndex) {
      
      /// Add the position to the return array.
      let i = distance(from: startIndex,
                         to: range.lowerBound)
      indices.append(i)
      
      /// Get the position of the last character
      /// of the search string.
      let offset = occurrence
        .distance(from: occurrence.startIndex,
                  to: occurrence.endIndex) - 1
      
      /// Get the index of the offset in the string,
      /// else break if we are at the end of the string.
      guard let after = index(range.lowerBound,
                              offsetBy: offset,
                              limitedBy: endIndex)
        else { break }
                              
      /// Continue searching from the new position.
      position = index(after: after)
    }
    
    return indices
  }
}

// MIT License:

/*
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.

 IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
