# iRacingSDK
A Swift MacOS framework for reading iRacing .ibt files.

### Note
I'm not on the iRacing service at this point, and as such I'm using telemetry files I still have from circa 2016/2017.
I'm sure iRacing will have updated them since then, if so and if you'd like to help then please drop me some up-to-date .ibt files via email at sociiw@gmail.com

## Usage
Import `iRacingSDK.framework` into your project.

Use the `Telemetry` struct to create a telemetry instance from a URL pointing to an iRacing .ibt file.
```swift
import Foundation
import iRacingSDK

let url = URL(fileURLWithPath: "/Volumes/PathToYourTelemetryFolder/radical sr8_oulton intnochicane 2016-02-10 19-54-52.ibt")
guard let telemetry = Telemetry(url: url) else {
  // break/return/other error code
}

print(String(describing: telemetry))
// 10 Feb 2016
// Oulton Park Circuit - International w/no Chicanes
// Radical SR8
```
You can access `String` dictionaries for:
```swift
telemetry.info // Session information
telemetry.options // Session options
telemetry.driver // Driver information
```
and an `Array` of `String` dictionaries for the drivers in the session:
```swift
telemetry.drivers // Drivers in the session
```
### Telemetry Channels
Telemetry channels can be accessed using the `channel(named:)` method.
Strings containing the channel names can be found in the following objects:
- Tyres
- Suspension
- Brakes
- Engine
- Session
- Laps
- Input
- Weather
- Vehicle
- PitCrew
- Sim
- Player
- InCar

Example:
```swift
let channel = telemetry.channel(named: Tyres.LFpressure)
print(String(describing: channel))
// LF tire pressure (kPa) : Float
```
Data for each channel is loaded into in memory when a channel is returned from the `channel(named:)` method,
and can be accessed via the `samples` property which returns an array:
```swift
for index in 3600..<3660 {
  print(channel.samples[index])
}
// 162.2271
// 162.22772
// 162.22835
// ... etc...
// 162.26189
// 162.26242
```
