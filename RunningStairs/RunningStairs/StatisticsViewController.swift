//
//  StatisticsViewController.swift
//  RunningStairs
//
//  Created by Vlad on 07/05/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController, MotionDetectorProtocol {
    
    
    @IBOutlet weak var activityLabel: UILabel!
    
    @IBOutlet weak var paceLabel: UILabel!
    
    @IBOutlet weak var altitudeLabel: UILabel!
    
    @IBOutlet weak var directionLabel: UILabel!
    
    @IBOutlet weak var floorsUpLabel: UILabel!
    
    @IBOutlet weak var floorsDownLabel: UILabel!

    let motionDetector = MotionDetector()
    
    var canChangeDirection = true
    
    var previousAltitude : Double!
    var currentAltitude : Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        motionDetector.delegate = self
        
    }
    
    @IBAction func startRunningBtnPressed(_ sender: UIButton) {
        
        motionDetector.startUpdating()
    }
    
    // MARK - MotionDetectorProtocol methods
    
    func updateActivityType(activityType: String) {
        self.activityLabel.text = activityType
    }
    
    func updatePace(pace: String) {
        self.paceLabel.text = pace
    }
    
    func updateAltitude(altitude: Double) {
        self.altitudeLabel.text = String(altitude)
        self.currentAltitude = altitude
        
        
        synchronize(lockObj: canChangeDirection as AnyObject) {
            // if can change direction == true
            if canChangeDirection {
                canChangeDirection = false
                self.previousAltitude = altitude
                runCode(in: 5.0) {
                    
                    self.setupDirection()
                    
                }
            }
        }
        
      
    }
    
    func setupDirection() {
        
        // direction is down
        if self.previousAltitude > self.currentAltitude + 0.5 {
            self.directionLabel.text = "Down"
        }
            
        // direction is up
        else if self.previousAltitude < self.currentAltitude - 0.5 {
            self.directionLabel.text = "Up"
        }
        
        // else don't change direction, leave it as it is because there is not much change in the altitude and you can't know for sure if the user is going up or down
        
        self.canChangeDirection = true
    }
    
    func updateFloorsUp(floorsUp: String) {
        self.floorsUpLabel.text = floorsUp
    }
    
    func updateFloorsDown(floorsDown: String) {
        self.floorsDownLabel.text = floorsDown
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

