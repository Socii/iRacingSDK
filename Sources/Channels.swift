// Channels.swift

// Copyright © 2021 Socii. All rights reserved.
// MIT License @ end of file.

import Foundation

// MARK: Definition

/// Channel names.
///
public struct Channels {
  
  /// Strings for tyre channels.
  public enum Tyres { }
  
  /// Strings for suspension channels.
  public enum Suspension { }
  
  /// Strings for brackes channels.
  public enum Brakes { }
  
  /// Strings for engine channels.
  public enum Engine { }
  
  /// Strings for session channels.
  public enum Session { }
  
  /// Strings for laps channels.
  public enum Laps { }
  
  /// Strings for input channels.
  public enum Input { }
  
  /// Strings for weather channels.
  public enum Weather { }
  
  /// Strings for orientation channels.
  public enum Orientation { }

  /// Strings for pit crew channels.
  public enum PitCrew { }
  
  /// Strings for sim channels.
  public enum Sim { }
  
  /// Strings for player channels.
  public enum Player { }
}

// MARK: - Player Strings

public extension Channels.Player {
  static let CarDriverIncidentCount = "PlayerCarDriverIncidentCount"
  static let CarTeamIncidentCount = "PlayerCarTeamIncidentCount"
  static let TrackSurface = "PlayerTrackSurface"
  static let CarIdx = "PlayerCarIdx"
  static let CarClassPosition = "PlayerCarClassPosition"
  static let CarMyIncidentCount = "PlayerCarMyIncidentCount"
  static let CarPosition = "PlayerCarPosition"
  static let TrackSurfaceMaterial = "PlayerTrackSurfaceMaterial"
  
  // FIXME: Not sure these go here.
  static let IsOnTrackCar = "IsOnTrackCar"
  static let EnterExitReset = "EnterExitReset"
  static let IsOnTrack = "IsOnTrack"
  static let DriverMarker = "DriverMarker"
}

// MARK: - Tyres Strings

public extension Channels.Tyres {
  static let RRtempCR = "RRtempCR"
  static let RRwearM = "RRwearM"
  static let LRwearL = "LRwearL"
  static let LFwearM = "LFwearM"
  static let RFspeed = "RFspeed"
  static let RRtempCL = "RRtempCL"
  static let RRtempL = "RRtempL"
  static let TireLF_RumblePitch = "TireLF_RumblePitch"
  static let LFcoldPressure = "LFcoldPressure"
  static let LFtempCL = "LFtempCL"
  static let LRwearR = "LRwearR"
  static let LFwearR = "LFwearR"
  static let LRtempCR = "LRtempCR"
  static let LRcoldPressure = "LRcoldPressure"
  static let RFtempCR = "RFtempCR"
  static let RFtempM = "RFtempM"
  static let RFcoldPressure = "RFcoldPressure"
  static let LFtempL = "LFtempL"
  static let RFtempCL = "RFtempCL"
  static let LFtempCM = "LFtempCM"
  static let RFtempR = "RFtempR"
  static let TireLR_RumblePitch = "TireLR_RumblePitch"
  static let LRtempR = "LRtempR"
  static let RRcoldPressure = "RRcoldPressure"
  static let LFspeed = "LFspeed"
  static let LFtempM = "LFtempM"
  static let RRwearR = "RRwearR"
  static let RRtempCM = "RRtempCM"
  static let LFwearL = "LFwearL"
  static let RRwearL = "RRwearL"
  static let TireRR_RumblePitch = "TireRR_RumblePitch"
  static let RFwearL = "RFwearL"
  static let RFwearM = "RFwearM"
  static let LRtempL = "LRtempL"
  static let RRspeed = "RRspeed"
  static let RFtempL = "RFtempL"
  static let LRpressure = "LRpressure"
  static let LFpressure = "LFpressure"
  static let LRtempCL = "LRtempCL"
  static let LRwearM = "LRwearM"
  static let RRtempM = "RRtempM"
  static let TireRF_RumblePitch = "TireRF_RumblePitch"
  static let LRspeed = "LRspeed"
  static let LRtempCM = "LRtempCM"
  static let RFtempCM = "RFtempCM"
  static let RFpressure = "RFpressure"
  static let RRpressure = "RRpressure"
  static let LFtempR = "LFtempR"
  static let RRtempR = "RRtempR"
  static let RFwearR = "RFwearR"
  static let LFtempCR = "LFtempCR"

}

// MARK: - Suspension Strings

public extension Channels.Suspension {
  static let RFshockDefl = "RFshockDefl"
  static let LFrideHeight = "LFrideHeight"
  static let LFshockVel = "LFshockVel"
  static let LRshockDefl = "LRshockDefl"
  static let LFshockDefl = "LFshockDefl"
  static let RRshockVel = "RRshockVel"
  static let RRrideHeight = "RRrideHeight"
  static let RFshockVel = "RFshockVel"
  static let LRshockVel = "LRshockVel"
  static let RRshockDefl = "RRshockDefl"
  static let RFrideHeight = "RFrideHeight"
  static let CFSRrideHeight = "CFSRrideHeight"
  static let LRrideHeight = "LRrideHeight"

}

// MARK: - Brakes Strings

public extension Channels.Brakes {
  static let dcABS = "dcABS"
  static let dcBrakeBias = "dcBrakeBias"
  static let LRbrakeLinePress = "LRbrakeLinePress"
  static let RFbrakeLinePress = "RFbrakeLinePress"
  static let RRbrakeLinePress = "RRbrakeLinePress"
  static let LFbrakeLinePress = "LFbrakeLinePress"

}

// MARK: - Engine Strings

public extension Channels.Engine {
  static let WaterLevel = "WaterLevel"
  static let RPM = "RPM"
  static let EngineWarnings = "EngineWarnings"
  static let FuelPress = "FuelPress"
  static let OilLevel = "OilLevel"
  static let WaterTemp = "WaterTemp"
  static let ShiftGrindRPM = "ShiftGrindRPM"
  static let Voltage = "Voltage"
  static let OilPress = "OilPress"
  static let ManifoldPress = "ManifoldPress"
  static let OilTemp = "OilTemp"
  static let dcThrottleShape = "dcThrottleShape"
  static let dcTractionControl = "dcTractionControl"
  static let ShiftIndicatorPct = "ShiftIndicatorPct"
  static let FuelLevelPct = "FuelLevelPct"
  static let FuelLevel = "FuelLevel"
  static let Gear = "Gear"
  static let FuelUsePerHour = "FuelUsePerHour"
  static let dcFuelMixture = "dcFuelMixture"
  static let ShiftPowerPct = "ShiftPowerPct"

}

// MARK: - Pit Crew Strings

public extension Channels.PitCrew {
  static let OnPitRoad = "OnPitRoad"
  static let PitOptRepairLeft = "PitOptRepairLeft"
  static let PitRepairLeft = "PitRepairLeft"
  static let PitSvFuel = "PitSvFuel"
  static let TrackTempCrew = "TrackTempCrew"
  static let PitSvRRP = "PitSvRRP"
  static let PitSvRFP = "PitSvRFP"
  static let PitSvLFP = "PitSvLFP"
  static let PitSvFlags = "PitSvFlags"
  static let PitSvLRP = "PitSvLRP"

}

// MARK: - Session Strings

public extension Channels.Session {
  static let SessionTime = "SessionTime"
  static let SessionLapsRemainEx = "SessionLapsRemainEx"
  static let SessionState = "SessionState"
  static let SessionTick = "SessionTick"
  static let SessionLapsRemain = "SessionLapsRemain"
  static let SessionUniqueID = "SessionUniqueID"
  static let SessionNum = "SessionNum"
  static let SessionTimeRemain = "SessionTimeRemain"
  
}

// MARK: - Laps Strings

public extension Channels.Laps {
  
  static let LapDeltaToSessionOptimalLap_DD = "LapDeltaToSessionOptimalLap_DD"
  static let LapDeltaToBestLap = "LapDeltaToBestLap"
  static let LapLastLapTime = "LapLastLapTime"
  static let LapDist = "LapDist"
  static let LapDeltaToSessionBestLap = "LapDeltaToSessionBestLap"
  static let LapCurrentLapTime = "LapCurrentLapTime"
  static let LapDeltaToSessionBestLap_DD = "LapDeltaToSessionBestLap_DD"
  static let LapDeltaToOptimalLap_DD = "LapDeltaToOptimalLap_DD"
  static let LapLasNLapSeq = "LapLasNLapSeq"
  static let LapDeltaToOptimalLap = "LapDeltaToOptimalLap"
  static let LapDeltaToSessionOptimalLap = "LapDeltaToSessionOptimalLap"
  static let Lap = "Lap"
  static let LapBestNLapLap = "LapBestNLapLap"
  static let LapBestNLapTime = "LapBestNLapTime"
  static let LapDeltaToBestLap_DD = "LapDeltaToBestLap_DD"
  static let LapDeltaToSessionLastlLap_OK = "LapDeltaToSessionLastlLap_OK"
  static let LapBestLapTime = "LapBestLapTime"
  static let LapDeltaToSessionBestLap_OK = "LapDeltaToSessionBestLap_OK"
  static let LapDeltaToOptimalLap_OK = "LapDeltaToOptimalLap_OK"
  static let LapCompleted = "LapCompleted"
  static let LapDistPct = "LapDistPct"
  static let LapDeltaToSessionOptimalLap_OK = "LapDeltaToSessionOptimalLap_OK"
  static let LapLastNLapTime = "LapLastNLapTime"
  static let LapDeltaToSessionLastlLap_DD = "LapDeltaToSessionLastlLap_DD"
  static let LapDeltaToBestLap_OK = "LapDeltaToBestLap_OK"
  static let LapBestLap = "LapBestLap"
  static let LapDeltaToSessionLastlLap = "LapDeltaToSessionLastlLap"

}

// MARK: - Input Strings

public extension Channels.Input {
  static let ThrottleRaw = "ThrottleRaw"
  static let Clutch = "Clutch"
  static let PushToPass = "PushToPass"
  static let SteeringWheelAngle = "SteeringWheelAngle"
  static let HandbrakeRaw = "HandbrakeRaw"
  static let SteeringWheelAngleMax = "SteeringWheelAngleMax"
  static let Brake = "Brake"
  static let BrakeRaw = "BrakeRaw"
  static let Throttle = "Throttle"
  
  // FIXME: Not sure these go here.
  static let SteeringWheelPctTorque = "SteeringWheelPctTorque"
  static let SteeringWheelPctTorqueSign = "SteeringWheelPctTorqueSign"

}

// MARK: - Weather Strings

public extension Channels.Weather {
  static let WeatherType = "WeatherType"
  static let Skies = "Skies"
  static let AirPressure = "AirPressure"
  static let TrackTemp = "TrackTemp"
  static let WindVel = "WindVel"
  static let FogLevel = "FogLevel"
  static let WindDir = "WindDir"
  static let RelativeHumidity = "RelativeHumidity"
  static let AirDensity = "AirDensity"
  static let AirTemp = "AirTemp"

}

// MARK: - Orientation Strings

public extension Channels.Orientation {
  static let Yaw = "Yaw"
  static let LatAccel = "LatAccel"
  static let LongAccel = "LongAccel"
  static let YawNorth = "YawNorth"
  static let VertAccel = "VertAccel"
  static let Roll = "Roll"
  static let RollRate = "RollRate"
  static let YawRate = "YawRate"
  static let VelocityY = "VelocityY"
  static let Lon = "Lon"
  static let Lat = "Lat"
  static let PitchRate = "PitchRate"
  static let Pitch = "Pitch"
  static let VelocityX = "VelocityX"
  static let Speed = "Speed"
  static let VelocityZ = "VelocityZ"

}

// MARK: - Sim Strings

public extension Channels.Sim {
  static let CpuUsageBG = "CpuUsageBG"
  static let FrameRate = "FrameRate"
}

// MARK: - Unsure

private struct Unsure {
  static let Alt = "Alt"
  static let SteeringWheelTorque = "SteeringWheelTorque"
  static let SteeringWheelPctDamper = "SteeringWheelPctDamper"
  static let SteeringWheelPctTorqueSignStops = "SteeringWheelPctTorqueSignStops"
  
}

// MIT License:

/*
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.

 IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
