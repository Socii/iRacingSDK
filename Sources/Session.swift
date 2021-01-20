// Session.swift

// Copyright © 2021 Socii. All rights reserved.
// MIT License @ end of file.

import Foundation

// MARK: Definition

/// An object containing the telemetry session information.
///
struct Session {
  
  /// The session weekend object.
  private let weekend: Weekend
  
  /// Creates a new Session from a YAML string.
  ///
  /// - Parameters:
  ///   - withYaml: String
  ///
  /// - Throws: throws an error if initialisation fails.
  ///
  public init?(yaml: String) {
    
    // Check yaml string is a valid else fail
    guard let start = yaml.index(after: "WeekendInfo:") else {
      logln("Unable to find \"WeekendInfo:\" in yaml string.", level: .error)
      return nil
    }
    
    guard let end = yaml.index(of: "SessionInfo:") else {
      logln("Unable to find \"SessionInfo:\" in yaml string.", level: .error)
      return nil
    }
    
    guard let weekend = Weekend(input: String(yaml[start..<end])) else {
      logln("Unable to create Weekend Struct from YAML string.", level: .error)
      return nil
    }
    
    // Store the weekend struct
    self.weekend = weekend
  }
}

// MARK: - Interface

extension Session {

  /// Returns a copy of the Weekend Info dictionary.
  var info: [String: String] {
    return weekend.info
  }
  
  /// Returns a copy of the Weekend Options dictionary.
  var options: [String: String] {
    return weekend.options
  }
  
  /// Returns a copy of the Drivers array.
//  var drivers: [[String: String]] {
//    return []
//  }
}

// MARK: - Weekend

/// A session weekend struct.
///
private struct Weekend {
  
  /// A dictionary containing session info.
  let info: [String: String]
  
  // A dictionary containing session options.
  let options: [String: String]
  
  // FIXME: Not sure what this is.
  let telemetryDiskFile = ""
  
  /// Attempt to create a `Weekend` struct from an input string.
  ///
  /// - Parameter input: The input string.
  ///
  init?(input: String) {
    
    // Find the start and end index of the info section.
    guard let infoStart = input.index(of: "TrackName:")
      else {
        logln("Unable to find the start of the Weekend Info YAML block.",
              level: .error)
        return nil
    }
    
    guard let infoEnd = input.index(of: "WeekendOptions:")
      else {
        logln("Unable to find the end of the Weekend Info YAML block.",
              level: .error)
        return nil
    }
    
    // Find the start and end index of the options section.
    guard let optionsStart = input.index(of: "NumStarters:")
      else {
        logln("Unable to find the start of the Weekend Options YAML block.",
              level: .error)
        return nil
    }
    
    guard let optionsEnd = input.index(of: "TelemetryOptions:")
      else {
        logln("Unable to find the end of the Weekend Options YAML block.",
              level: .error)
        return nil
    }
    
    // Build the info and options dictionaries.
    do {
      info = try YAML.toDictionary(String(input[infoStart..<infoEnd]))
    } catch {
      logln("Other YAML Error.", level: .error)
      return nil
    }

    do {
      options = try YAML.toDictionary(String(input[optionsStart..<optionsEnd]))
    } catch {
      logln("Other YAML Error.", level: .error)
      return nil
    }
  }
}

/*
// MARK: - Drivers
private struct Drivers {
 
  let user: [String: String]
  let drivers: [[String: String]]
  
  init?(input: String) {
    
    /// Find the start and end index of the DriverInfo section.
    guard let userStart = input.index(of: "DriverInfo:")
      else {
        logln("Unable to find the start of the Driver Info YAML block.")
        return nil
    }
    
    guard let userEnd = input.index(of: "Drivers:")
      else {
        logln("Unable to find the end of the Driver Info YAML block.")
        return nil
    }
    
    
    // Find the start and end index of the options section.
    guard let driversStart = input.index(of: "- CarIdx: 0")
      else {
        logln("Unable to find the start of the Drivers YAML block.")
        return nil
    }
    
    guard let driversEnd = input.index(of: "SplitTimeInfo:")
      else {
        logln("Unable to find the end of the Drivers YAML block.")
        return nil
    }
    
    /// Build the info and options dictionarys.
    do {
      user = try YAML.toDictionary(String(input[userStart..<userEnd]))
    } catch {
      logln("Other YAML Error.")
      return nil
    }
    
    var drivers = [String: String]()
    do {
      drivers = try YAML.toDictionary(String(input[driversStart..<driversEnd]))
    } catch {
      logln("Other YAML Error.")
      return nil
    }
  }
}
*/

// MIT License:

/*
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.

 IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
