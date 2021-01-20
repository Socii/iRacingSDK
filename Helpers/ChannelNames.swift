// ChannelNames.swift

// Copyright © 2021 Socii. All rights reserved.
// MIT License @ end of file.

#if DEBUG

import Foundation

public extension Telemetry {
  
  /// An attempt to group the iRacing channels.
  ///
  /// Prints all of the channel names to the console,
  /// formatted for cut-and-paste into the Channels Enum.
  /// Some channels are grouped incorrectly so a bit of
  /// re-arranging is needed.
  ///
  func printChannels() {
    var strings = [String:[String]]()
    strings.updateValue([], forKey: .tyres)
    strings.updateValue([], forKey: .suspension)
    strings.updateValue([], forKey: .brakes)
    strings.updateValue([], forKey: .engine)
    strings.updateValue([], forKey: .session)
    strings.updateValue([], forKey: .laps)
    strings.updateValue([], forKey: .input)
    strings.updateValue([], forKey: .weather)
    strings.updateValue([], forKey: .vehicle)
    strings.updateValue([], forKey: .pitcrew)
    strings.updateValue([], forKey: .sim)
    strings.updateValue([], forKey: .player)
    strings.updateValue([], forKey: .inCar)
    strings.updateValue([], forKey: .unsure)
    
    for channel in channels {
      let name = channel.value.name
      var string = ""
      string.append("  /// \(channel.value.description).\n")
      string.append("  static let \(name) = \"\(name)\"\n")
      
      if name.contains("dc") {
        appendDictionary(string, key: .inCar, dict: &strings)
      
      } else if name.contains(["wear", "speed", "temp", "Rumble", "cold", "pressure"]) {
        appendDictionary(string, key: .tyres, dict: &strings)

      } else if name.contains(["shock", "ride"]) {
        appendDictionary(string, key: .suspension, dict: &strings)
      
      } else if name.contains(["Brake", "brake", "ABS"]) {
        appendDictionary(string, key: .brakes, dict: &strings)
        
      } else if name.contains(["Engine", "Fuel", "RPM", "Oil", "Water", "Voltage", "Manifold"]) {
        appendDictionary(string, key: .engine, dict: &strings)
        
      } else if name.contains(["Session"]) {
        appendDictionary(string, key: .session, dict: &strings)
        
      } else if name.contains(["Lap"]) {
        appendDictionary(string, key: .laps, dict: &strings)
        
      } else if name.contains(["Steering", "Throttle", "Clutch"]) {
        appendDictionary(string, key: .input, dict: &strings)
        
      } else if name.contains(["Air", "Wind", "Skies", "Weather", "Fog", "Humidity", "TrackTemp"]) {
        appendDictionary(string, key: .weather, dict: &strings)
        
      } else if name.contains(["angle", "Rate", "Velocity", "Accel", "Yaw", "Roll", "Speed", "Alt", "Lat", "Lon"]) {
        appendDictionary(string, key: .vehicle, dict: &strings)
        
      } else if name.contains(["Pit"]) {
        appendDictionary(string, key: .pitcrew, dict: &strings)
        
      } else if name.contains(["Cpu", "FrameRate"]) {
        appendDictionary(string, key: .sim, dict: &strings)
        
      } else if name.contains(["Player", "Driver"]) {
        appendDictionary(string, key: .player, dict: &strings)
        
      } else {
        appendDictionary(string, key: .unsure, dict: &strings)
      }
    }
    
//    for item in strings[.unsure]! {
//      print(item)
//    }
            
    for string in strings {
      print("// MARK: - \(string.key)\n")
      print("public extension Channels.\(string.key) {\n")
      for item in strings[string.key]! {
        print(item)
      }
      print("}\n")
    }
  }
  
  private func appendDictionary(_ string: String, key: String,  dict: inout [String:[String]]) {
    var array = dict[key]!
    array.append(string)
    dict.updateValue(array, forKey: key)
  }
}

private extension String {
  
  func contains(_ strings: [String]) -> Bool {
    
    var result = false
    for string in strings {
      if self.contains(string) { result = true }
    }
    return result
  }
  
  static let tyres = "Tyres"
  static let suspension = "Suspension"
  static let brakes = "Brakes"
  static let engine = "Engine"
  static let session = "Session"
  static let laps = "Laps"
  static let input = "Input"
  static let weather = "Weather"
  static let vehicle = "Vehicle"
  static let pitcrew = "PitCrew"
  static let sim = "Sim"
  static let player = "Player"
  static let inCar = "InCar"
  static let unsure = "Unsure"
}

#endif

// MIT License:

/*
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.

 IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
