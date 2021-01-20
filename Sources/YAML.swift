// YAML.swift

// Copyright © 2021 Socii. All rights reserved.
// MIT License @ end of file.

import Foundation

/// A simple YAML parser based on the irsdk C++ code provided by iRacing.
///
struct YAML {
  
  private enum YAMLParserError: Error {
    case notAValidYAMLDocument(String)
  }
}

// MARK: - Model

extension YAML {
  
  /// Check if the input string begins with "---"
  /// and ends with "..." to signify this is a YAML document.
  ///
  /// - Parameters:
  ///   - input: String to check.
  /// - Returns: `true` if this is a valid yaml document,
  ///             otherwise `false`.
  ///
  static func isValidYaml(input: String) -> Bool {
    
    // Check begining of string.
    guard input.hasPrefix("---") else {
      logln("Not a valid YAML document:\n  The first three characters in the string must be \"---\".\n  First three characters of the string entered is \"\(input.prefix(3))\"\n", level: .error)
      return false
    }
    
    // Check end of string.
    guard input.hasSuffix("...\n") else {
      logln("Not a valid YAML document:\n  The last three characters in the string must be \"...\".\n  Last three characters of the string entered is \"\(input.suffix(3))\"\n", level: .error)
      return false
    }
    
    // Return true if both checks pass.
    return true
  }
  
  /// Converts a YAML string to a Swift dictionary.
  ///
  /// - Parameter yaml: Source string.
  /// - Returns: A dictionary of key/value pairs.
  ///
  static func toDictionary(_ yaml: String) throws -> [String: String] {
    
    /// The current state of the parser.
    enum State {
      case tab
      case key
      case seperator
      case value
    }
    
    // Expect to encounter the key field first.
    var state = State.key
    
    // Instantiate the key and value variables.
    var key = ""
    var value = ""
    
    // Create an empty dictionary.
    var dict: [String: String] = [:]
    
    // Iterate through each character in the input string.
    for char in yaml {
      switch char {
        
      // Spaces are used to denote tab depth and are also allowed
      // in value fields, but not allowed in keys.
      // Not interested in tracking tab depth as of now.
      case " ":
        
        // Spaces are allowed in the value field,
        // so is added to the value String.
        if state == .value {
          value.append(char)
          break
          
        // If this is a space after a colon then we are
        // now reading the value field.
        } else if state == .seperator {
          state = .value
          break
        }
          
        // Otherwise ignore.
        else { break }
        
      // ": " (colon + space) is used to seperate key/value pairs in Yaml.
      // Colons are allowed in a Yaml value field (but a colon followed
      // by a space isn't), so we need to check we check for the colon
      // first and then check if there is a space immediately following.
      case ":":
        
        // If we are currently reading the key,
        // then this will be the start of the key seperator.
        if state == .key {
          state = .seperator
          break
          
        // ":" is allowed in the value field,
        // so add it to the value string.
        } else if state == .value {
          value.append(char)
          break
          
        // Otherwise ignore. This should never be reached as
        // ":" is not allowed in the key, tab, or return.
        } else { break }
        
      // We should only encounter a new line or carriage return
      // at the end of a value field.
      // When we reach the end of the current line the current
      // key and value variables are added to the dictionary,
      // and the variables are cleared ready for the next item.
      case "\n", "\r":
        
        // Should be currenty reading the value, so check for this first.
        if state == .value {
          
          // State is now End Of Line.
          state = .key
          
          // Add current key and value string to the dictionary.
          dict.updateValue(value, forKey: key)
          
          // Clear the strings for the next YAML item.
          key = ""
          value = ""
          break
          
        // If we encounter a carriage return anywhere other than at
        // the end of the value field then something has gone wrong.
        } else {
          // FIXME:  *** error handling needed. ***
          break
        }
        
      // Any other characters encountered are added to the
      // key, seperator, or value fields depending on the
      // current state.
      default:
        
        // If we are currently reading the key,
        // then add to the key variable.
        if state == .key {
          key.append(char)
          break
          
        // If we are reading the value field,
        // then add to the value variable.
        } else if state == .value {
          value.append(char)
          break
          
        // Ignore other cases.
        } else { break }
      }
    }
    
    // Return the dictionary.
    return dict
  }
}

// MIT License:

/*
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.

 IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
