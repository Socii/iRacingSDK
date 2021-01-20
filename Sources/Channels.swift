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
  
  /// Strings for brakes channels.
  public enum Brakes { }
  
  /// Strings for engine channels.
  public enum Engine { }
  
  /// Strings for session channels.
  public enum Session { }
  
  /// Strings for laps channels.
  public enum Laps { }
  
  /// Strings for user input channels.
  public enum Input { }
  
  /// Strings for weather channels.
  public enum Weather { }
  
  /// Strings for vehicle orientation and forces channels.
  public enum Vehicle { }

  /// Strings for pit crew channels.
  public enum PitCrew { }
  
  /// Strings for sim channels.
  public enum Sim { }
  
  /// Strings for player channels.
  public enum Player { }
  
  /// String for in-car adjustments.
  public enum InCar { }
  
//  public enum Unsure { }
}

// MARK: - In Car Adjustments

public extension Channels.InCar {
  
  /// In car traction control adjustment.
  static let dcTractionControl = "dcTractionControl"

  /// In car fuel mixture adjustment.
  static let dcFuelMixture = "dcFuelMixture"
  
  /// In car abs adjustment.
  static let dcABS = "dcABS"
  
  /// In car brake bias adjustment.
  static let dcBrakeBias = "dcBrakeBias"
  
  /// In car throttle shape adjustment.
  static let dcThrottleShape = "dcThrottleShape"

}

// MARK: - Weather

public extension Channels.Weather {

  /// Wind velocity at start/finish line.
  static let WindVel = "WindVel"

  /// Fog level.
  static let FogLevel = "FogLevel"

  /// Temperature of air at start/finish line.
  static let AirTemp = "AirTemp"

  /// Weather type (0=constant, 1=dynamic).
  static let WeatherType = "WeatherType"

  /// Density of air at start/finish line.
  static let AirDensity = "AirDensity"

  /// Skies (0=clear/1=p cloudy/2=m cloudy/3=overcast).
  static let Skies = "Skies"

  /// Temperature of track at start/finish line.
  static let TrackTemp = "TrackTemp"

  /// Relative Humidity.
  static let RelativeHumidity = "RelativeHumidity"

  /// Wind direction at start/finish line.
  static let WindDir = "WindDir"

  /// Pressure of air at start/finish line.
  static let AirPressure = "AirPressure"

}


// MARK: - Vehicle

public extension Channels.Vehicle {
  
  /// Altitude in meters.
  static let Alt = "Alt"
  
  /// Vertical acceleration (including gravity).
  static let VertAccel = "VertAccel"

  /// Longitudinal acceleration (including gravity).
  static let LongAccel = "LongAccel"

  /// Roll rate.
  static let RollRate = "RollRate"

  /// Lateral acceleration (including gravity).
  static let LatAccel = "LatAccel"

  /// GPS vehicle speed.
  static let Speed = "Speed"

  /// Y velocity.
  static let VelocityY = "VelocityY"

  /// Pitch rate.
  static let PitchRate = "PitchRate"

  /// Roll orientation.
  static let Roll = "Roll"

  /// X velocity.
  static let VelocityX = "VelocityX"

  /// Yaw rate.
  static let YawRate = "YawRate"

  /// Z velocity.
  static let VelocityZ = "VelocityZ"

  /// Yaw orientation.
  static let Yaw = "Yaw"

  /// Yaw orientation relative to north.
  static let YawNorth = "YawNorth"
  
  /// Pitch orientation.
  static let Pitch = "Pitch"
  
  /// Latitude in decimal degrees.
  static let Lat = "Lat"
  
  /// Longitude in decimal degrees.
  static let Lon = "Lon"

}

// MARK: - Engine

public extension Channels.Engine {
  
  /// DEPRECATED use DriverCarSLBlinkRPM instead.
  static let ShiftIndicatorPct = "ShiftIndicatorPct"

  /// Engine voltage.
  static let Voltage = "Voltage"

  /// Liters of fuel remaining.
  static let FuelLevel = "FuelLevel"

  /// Bitfield for warning lights.
  static let EngineWarnings = "EngineWarnings"

  /// Engine manifold pressure.
  static let ManifoldPress = "ManifoldPress"

  /// Engine oil pressure.
  static let OilPress = "OilPress"

  /// Engine coolant level.
  static let WaterLevel = "WaterLevel"

  /// Engine oil level.
  static let OilLevel = "OilLevel"

  /// Engine fuel used instantaneous.
  static let FuelUsePerHour = "FuelUsePerHour"

  /// Engine oil temperature.
  static let OilTemp = "OilTemp"

  /// Engine coolant temp.
  static let WaterTemp = "WaterTemp"

  /// Percent fuel remaining.
  static let FuelLevelPct = "FuelLevelPct"

  /// Engine RPM.
  static let RPM = "RPM"

  /// RPM of shifter grinding noise.
  static let ShiftGrindRPM = "ShiftGrindRPM"

  /// Engine fuel pressure.
  static let FuelPress = "FuelPress"
  
  /// Friction torque applied to gears when shifting or grinding.
  static let ShiftPowerPct = "ShiftPowerPct"

}

// MARK: - Suspension

public extension Channels.Suspension {

  /// RR shock deflection.
  static let RRshockDefl = "RRshockDefl"

  /// Center front splitter ride height.
  static let CFSRrideHeight = "CFSRrideHeight"

  /// LR shock deflection.
  static let LRshockDefl = "LRshockDefl"

  /// LF shock deflection.
  static let LFshockDefl = "LFshockDefl"

  /// LR ride height.
  static let LRrideHeight = "LRrideHeight"

  /// RF ride height.
  static let RFrideHeight = "RFrideHeight"

  /// LF ride height.
  static let LFrideHeight = "LFrideHeight"

  /// RF shock deflection.
  static let RFshockDefl = "RFshockDefl"

  /// LR shock velocity.
  static let LRshockVel = "LRshockVel"

  /// RF shock velocity.
  static let RFshockVel = "RFshockVel"

  /// RR ride height.
  static let RRrideHeight = "RRrideHeight"

  /// RR shock velocity.
  static let RRshockVel = "RRshockVel"

  /// LF shock velocity.
  static let LFshockVel = "LFshockVel"

}

// MARK: - Sim

public extension Channels.Sim {

  /// Percent of available tim bg thread took with a 1 sec avg.
  static let CpuUsageBG = "CpuUsageBG"
  
  /// Average frames per second.
  static let FrameRate = "FrameRate"
}

// MARK: - Brakes

public extension Channels.Brakes {

  /// RF brake line pressure.
  static let RFbrakeLinePress = "RFbrakeLinePress"

  /// LF brake line pressure.
  static let LFbrakeLinePress = "LFbrakeLinePress"

  /// 0=brake released to 1=max pedal force.
  static let Brake = "Brake"

  /// RR brake line pressure.
  static let RRbrakeLinePress = "RRbrakeLinePress"

  /// LR brake line pressure.
  static let LRbrakeLinePress = "LRbrakeLinePress"

}

// MARK: - PitCrew

public extension Channels.PitCrew {
  
  /// Temperature of track measured by crew around track.
  static let TrackTempCrew = "TrackTempCrew"
  
  /// Time left for optional repairs if repairs are active.
  static let PitOptRepairLeft = "PitOptRepairLeft"

  /// Pit service left rear tire pressure.
  static let PitSvLRP = "PitSvLRP"

  /// Pit service right rear tire pressure.
  static let PitSvRRP = "PitSvRRP"

  /// Time left for mandatory pit repairs if repairs are active.
  static let PitRepairLeft = "PitRepairLeft"

  /// Is the player car on pit road between the cones.
  static let OnPitRoad = "OnPitRoad"

  /// Pit service right front tire pressure.
  static let PitSvRFP = "PitSvRFP"

  /// Bitfield of pit service checkboxes.
  static let PitSvFlags = "PitSvFlags"

  /// Pit service left front tire pressure.
  static let PitSvLFP = "PitSvLFP"
  
  /// Pit service fuel add amount.
  static let PitSvFuel = "PitSvFuel"

}

// MARK: - Laps

public extension Channels.Laps {
  
  /// Rate of change of delta time for session last lap.
  static let LapDeltaToSessionLastlLap_DD = "LapDeltaToSessionLastlLap_DD"

  /// Rate of change of delta time for session best lap.
  static let LapDeltaToSessionBestLap_DD = "LapDeltaToSessionBestLap_DD"

  /// Delta time for session last lap is valid.
  static let LapDeltaToSessionLastlLap_OK = "LapDeltaToSessionLastlLap_OK"

  /// Delta time for session best lap.
  static let LapDeltaToSessionBestLap = "LapDeltaToSessionBestLap"

  /// Delta time for session best lap is valid.
  static let LapDeltaToSessionBestLap_OK = "LapDeltaToSessionBestLap_OK"

  /// Delta time for session optimal lap.
  static let LapDeltaToSessionOptimalLap = "LapDeltaToSessionOptimalLap"

  /// Rate of change of delta time for session optimal lap.
  static let LapDeltaToSessionOptimalLap_DD = "LapDeltaToSessionOptimalLap_DD"

  /// Delta time for session optimal lap is valid.
  static let LapDeltaToSessionOptimalLap_OK = "LapDeltaToSessionOptimalLap_OK"

  /// Delta time for session last lap.
  static let LapDeltaToSessionLastlLap = "LapDeltaToSessionLastlLap"

  /// Player best N average lap time.
  static let LapBestNLapTime = "LapBestNLapTime"

  /// Player num consecutive clean laps completed for N average.
  static let LapLasNLapSeq = "LapLasNLapSeq"

  /// Players last lap time.
  static let LapLastLapTime = "LapLastLapTime"

  /// Players best lap time.
  static let LapBestLapTime = "LapBestLapTime"

  /// Rate of change of delta time for best lap.
  static let LapDeltaToBestLap_DD = "LapDeltaToBestLap_DD"

  /// Delta time for optimal lap is valid.
  static let LapDeltaToOptimalLap_OK = "LapDeltaToOptimalLap_OK"

  /// Player last N average lap time.
  static let LapLastNLapTime = "LapLastNLapTime"

  /// Percentage distance around lap.
  static let LapDistPct = "LapDistPct"

  /// Rate of change of delta time for optimal lap.
  static let LapDeltaToOptimalLap_DD = "LapDeltaToOptimalLap_DD"

  /// Laps started count.
  static let Lap = "Lap"

  /// Delta time for optimal lap.
  static let LapDeltaToOptimalLap = "LapDeltaToOptimalLap"

  /// Delta time for best lap.
  static let LapDeltaToBestLap = "LapDeltaToBestLap"

  /// Player last lap in best N average lap time.
  static let LapBestNLapLap = "LapBestNLapLap"

  /// Delta time for best lap is valid.
  static let LapDeltaToBestLap_OK = "LapDeltaToBestLap_OK"

  /// Meters traveled from S/F this lap.
  static let LapDist = "LapDist"

  /// Estimate of players current lap time as shown in F3 box.
  static let LapCurrentLapTime = "LapCurrentLapTime"

  /// Players best lap number.
  static let LapBestLap = "LapBestLap"

  /// Laps completed count.
  static let LapCompleted = "LapCompleted"

}

// MARK: - Tyres

public extension Channels.Tyres {

  /// LF tire left percent tread remaining.
  static let LFwearL = "LFwearL"

  /// RF tire left surface temperature.
  static let RFtempL = "RFtempL"

  /// LF tire right surface temperature.
  static let LFtempR = "LFtempR"

  /// RR tire middle percent tread remaining.
  static let RRwearM = "RRwearM"

  /// LR tire pressure.
  static let LRpressure = "LRpressure"

  /// LR tire cold pressure, as set in the garage.
  static let LRcoldPressure = "LRcoldPressure"

  /// Players RR Tire Sound rumblestrip pitch.
  static let TireRR_RumblePitch = "TireRR_RumblePitch"

  /// LF tire cold pressure, as set in the garage.
  static let LFcoldPressure = "LFcoldPressure"

  /// LF tire middle carcass temperature.
  static let LFtempCM = "LFtempCM"

  /// LF tire right carcass temperature.
  static let LFtempCR = "LFtempCR"

  /// RR tire middle carcass temperature.
  static let RRtempCM = "RRtempCM"

  /// LR tire left surface temperature.
  static let LRtempL = "LRtempL"

  /// LR tire left carcass temperature.
  static let LRtempCL = "LRtempCL"

  /// LF tire left carcass temperature.
  static let LFtempCL = "LFtempCL"

  /// RF tire left carcass temperature.
  static let RFtempCL = "RFtempCL"

  /// LR tire right percent tread remaining.
  static let LRwearR = "LRwearR"

  /// Players RF Tire Sound rumblestrip pitch.
  static let TireRF_RumblePitch = "TireRF_RumblePitch"

  /// RR tire cold pressure, as set in the garage.
  static let RRcoldPressure = "RRcoldPressure"

  /// RR tire left carcass temperature.
  static let RRtempCL = "RRtempCL"

  /// LF wheel speed.
  static let LFspeed = "LFspeed"

  /// RF tire cold pressure, as set in the garage.
  static let RFcoldPressure = "RFcoldPressure"

  /// RR tire right percent tread remaining.
  static let RRwearR = "RRwearR"

  /// RF tire right carcass temperature.
  static let RFtempCR = "RFtempCR"

  /// RR tire middle surface temperature.
  static let RRtempM = "RRtempM"

  /// RF tire right surface temperature.
  static let RFtempR = "RFtempR"

  /// RR tire left surface temperature.
  static let RRtempL = "RRtempL"

  /// LF tire middle surface temperature.
  static let LFtempM = "LFtempM"

  /// LR tire right carcass temperature.
  static let LRtempCR = "LRtempCR"

  /// Players LR Tire Sound rumblestrip pitch.
  static let TireLR_RumblePitch = "TireLR_RumblePitch"

  /// RF tire middle percent tread remaining.
  static let RFwearM = "RFwearM"

  /// LF tire middle percent tread remaining.
  static let LFwearM = "LFwearM"

  /// RF tire pressure.
  static let RFpressure = "RFpressure"

  /// LR tire middle percent tread remaining.
  static let LRwearM = "LRwearM"

  /// LR tire right surface temperature.
  static let LRtempR = "LRtempR"

  /// RR tire right carcass temperature.
  static let RRtempCR = "RRtempCR"

  /// RR tire left percent tread remaining.
  static let RRwearL = "RRwearL"

  /// RF tire left percent tread remaining.
  static let RFwearL = "RFwearL"

  /// RF wheel speed.
  static let RFspeed = "RFspeed"

  /// LF tire left surface temperature.
  static let LFtempL = "LFtempL"

  /// LR tire middle surface temperature.
  static let LRtempM = "LRtempM"

  /// Players LF Tire Sound rumblestrip pitch.
  static let TireLF_RumblePitch = "TireLF_RumblePitch"

  /// RR wheel speed.
  static let RRspeed = "RRspeed"

  /// LR tire left percent tread remaining.
  static let LRwearL = "LRwearL"

  /// LF tire right percent tread remaining.
  static let LFwearR = "LFwearR"

  /// RR tire pressure.
  static let RRpressure = "RRpressure"

  /// LR wheel speed.
  static let LRspeed = "LRspeed"

  /// RF tire right percent tread remaining.
  static let RFwearR = "RFwearR"

  /// RF tire middle carcass temperature.
  static let RFtempCM = "RFtempCM"

  /// LR tire middle carcass temperature.
  static let LRtempCM = "LRtempCM"

  /// RR tire right surface temperature.
  static let RRtempR = "RRtempR"

  /// RF tire middle surface temperature.
  static let RFtempM = "RFtempM"

  /// LF tire pressure.
  static let LFpressure = "LFpressure"

}

// MARK: - Session

public extension Channels.Session {

  /// Session ID.
  static let SessionUniqueID = "SessionUniqueID"

  /// Current update number.
  static let SessionTick = "SessionTick"

  /// Old laps left till session ends use SessionLapsRemainEx.
  static let SessionLapsRemain = "SessionLapsRemain"

  /// Session state.
  static let SessionState = "SessionState"

  /// New improved laps left till session ends.
  static let SessionLapsRemainEx = "SessionLapsRemainEx"

  /// Seconds since session start.
  static let SessionTime = "SessionTime"

  /// Seconds left till session ends.
  static let SessionTimeRemain = "SessionTimeRemain"

  /// Session number.
  static let SessionNum = "SessionNum"

}

// MARK: - Player

public extension Channels.Player {

  /// Players carIdx.
  static let PlayerCarIdx = "PlayerCarIdx"

  /// Teams current drivers incident count for this session.
  static let PlayerCarDriverIncidentCount = "PlayerCarDriverIncidentCount"

  /// Players team incident count for this session.
  static let PlayerCarTeamIncidentCount = "PlayerCarTeamIncidentCount"

  /// Players position in race.
  static let PlayerCarPosition = "PlayerCarPosition"

  /// Players car track surface type.
  static let PlayerTrackSurface = "PlayerTrackSurface"

  /// Players car track surface material type.
  static let PlayerTrackSurfaceMaterial = "PlayerTrackSurfaceMaterial"

  /// Players own incident count for this session.
  static let PlayerCarMyIncidentCount = "PlayerCarMyIncidentCount"

  /// Players class position in race.
  static let PlayerCarClassPosition = "PlayerCarClassPosition"

  /// Driver activated flag.
  static let DriverMarker = "DriverMarker"
  
  /// 1=Car on track physics running.
  static let IsOnTrackCar = "IsOnTrackCar"

  /// Indicate action the reset key will take 0 enter 1 exit 2 reset.
  static let EnterExitReset = "EnterExitReset"

  /// 1=Car on track physics running with player in car.
  static let IsOnTrack = "IsOnTrack"

}

// MARK: - Input

public extension Channels.Input {
  
  /// Push to pass button state.
  static let PushToPass = "PushToPass"

  /// Steering wheel angle.
  static let SteeringWheelAngle = "SteeringWheelAngle"

  /// Force feedback % max torque on steering shaft signed.
  static let SteeringWheelPctTorqueSign = "SteeringWheelPctTorqueSign"

  /// Raw throttle input 0=off throttle to 1=full throttle.
  static let ThrottleRaw = "ThrottleRaw"

  /// Force feedback % max torque on steering shaft unsigned.
  static let SteeringWheelPctTorque = "SteeringWheelPctTorque"

  /// Steering wheel max angle.
  static let SteeringWheelAngleMax = "SteeringWheelAngleMax"

  /// Output torque on steering shaft.
  static let SteeringWheelTorque = "SteeringWheelTorque"

  /// Force feedback % max damping.
  static let SteeringWheelPctDamper = "SteeringWheelPctDamper"

  /// 0=disengaged to 1=fully engaged.
  static let Clutch = "Clutch"

  /// 0=off throttle to 1=full throttle.
  static let Throttle = "Throttle"

  /// Force feedback % max torque on steering shaft signed stops.
  static let SteeringWheelPctTorqueSignStops = "SteeringWheelPctTorqueSignStops"
  
  /// Raw handbrake input 0=handbrake released to 1=max force.
  static let HandbrakeRaw = "HandbrakeRaw"
  
  /// Raw brake input 0=brake released to 1=max pedal force.
  static let BrakeRaw = "BrakeRaw"
  
  /// -1=reverse, 0=neutral, 1..n=current gear.
  static let Gear = "Gear"

}

// MIT License:

/*
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.

 IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
