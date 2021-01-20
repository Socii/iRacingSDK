// Debug.swift

// Copyright © 2021 Socii. All rights reserved.
// MIT License @ end of file.

import Cocoa

// MARK: Logger
enum LogLevel: String {
  case info = "✅"
  case warning = "⚠️"
  case error = "‼️"
}

/// Outputs the given item to the standard console,
/// along with the calling class and function name.
///
/// - Parameters:
///   - item: The object to print to the console.
///   - level: The log level as defined in the LogLevel enum.
///   - fileName: The callers filename.
///   - function: The callers function.
///
func logln(_ item: Any, level: LogLevel = .info, fileName: String = #file, function: String = #function) {
  let className = URL(fileURLWithPath: fileName).deletingPathExtension().lastPathComponent
  print("\(className).\(function) \(level.rawValue) \(item)")
}

// MIT License:

/*
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.

 IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
