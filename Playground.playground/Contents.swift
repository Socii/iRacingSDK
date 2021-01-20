import Foundation
import iRacingSDK

let url = URL(fileURLWithPath: "/Volumes/Work/4LD/4LD Motorsport/Telemetry/mercedesamggt3_watkinsglen fullcourse 2017-01-19 00-09-04.ibt")

let telemetry = Telemetry(url: url)!
print(String(describing: telemetry))

let channel = telemetry.channel(named: Channels.Tyres.LFtempCL)
print(String(describing: channel))

for index in 0..<60 {
  print("value = \(channel.sample(at: index))\n")
}
