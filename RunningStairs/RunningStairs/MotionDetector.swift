//
//  MotionDetector.swift
//  RunningStairs
//
//  Created by Vlad on 07/05/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import Foundation
import CoreMotion


protocol MotionDetectorProtocol {
    func updateActivityType(activityType : String)
    func updatePace(pace : String)
    func updateAltitude(altitude : Double)
    func updateFloorsUp(floorsUp : String)
    func updateFloorsDown(floorsDown : String)
}

class MotionDetector {
   
    private let activityManager = CMMotionActivityManager()
    private let altimeter = CMAltimeter()
    private let pedometer = CMPedometer()
    private let motionManager = CMMotionManager()
    private var activityType = ""
    private var pace = ""
    private var altidude : Double!
    private var accelerationZ = ""
    private var floorsUp = ""
    private var floorsDown = ""
    
    
    var delegate : MotionDetectorProtocol!
    
    private func startTrackingActivityType() {
        activityManager.startActivityUpdates(to: OperationQueue.main) {
            [weak self] (activity: CMMotionActivity?) in
            
            guard let activity = activity else { return }
            DispatchQueue.main.async {
                if activity.walking {
                    self?.activityType = "Walking"
                    self?.delegate.updateActivityType(activityType: (self?.activityType)!)
                } else if activity.stationary {
                    self?.activityType = "Stationary"
                     self?.delegate.updateActivityType(activityType: (self?.activityType)!)
                } else if activity.running {
                    self?.activityType = "Running"
                     self?.delegate.updateActivityType(activityType: (self?.activityType)!)
                } else if activity.automotive {
                    self?.activityType = "Automotive"
                    self?.delegate.updateActivityType(activityType: (self?.activityType)!)
                }
            }
        }
    }
    
    private func startCountingSteps() {
        pedometer.startUpdates(from: Date()) {
            [weak self] pedometerData, error in
            guard let pedometerData = pedometerData, error == nil else { return }
            
            DispatchQueue.main.async {
            
                if let pace = pedometerData.currentPace {
                    self?.pace = pace.stringValue
                }
                
                self?.floorsUp = (pedometerData.floorsAscended?.stringValue)!
                self?.floorsDown = (pedometerData.floorsDescended?.stringValue)!
                
                self?.delegate.updatePace(pace: (self?.pace)!)
                self?.delegate.updateFloorsDown(floorsDown: (self?.floorsDown)!)
                self?.delegate.updateFloorsUp(floorsUp: (self?.floorsUp)!)
            }
        }
    }
    
    private func startTrackingAltitude() {
            altimeter.startRelativeAltitudeUpdates(to: OperationQueue.main, withHandler: {
                [weak self] altitudeData, error in
                guard let altitudeData = altitudeData, error == nil else { return }
                
                guard let altitude = altitudeData.relativeAltitude as? Double else { return }
                
                self?.altidude = altitude
            
                self?.delegate.updateAltitude(altitude: (self?.altidude)!)
                } )
    }
    
    
    
    
    public func startUpdating() {
        if CMMotionActivityManager.isActivityAvailable() {
            startTrackingActivityType()
        }
        
        if CMPedometer.isStepCountingAvailable() {
            startCountingSteps()
        }
        
         if CMAltimeter.isRelativeAltitudeAvailable() {
            startTrackingAltitude()
        }
        
    }
    
}


