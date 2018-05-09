//
//  SecondTrackerViewController.swift
//  RunningStairs
//
//  Created by Vlad on 09/05/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit
import MotionDetector

class SecondTrackerViewController: UIViewController, RunningStairsProtocol {

    
    @IBOutlet weak var directionButton: UIButton!
    
    @IBOutlet weak var floorsButton: UIButton!
    
    @IBOutlet weak var paceLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    var seconds = 0
    var minutes = 0
    var hours = 0
    var timer = Timer()
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.
    
    
    var delegate : ActivityChangedProtocol!
    
    let motionDetector = MotionDetector()
    
    var canChangeDirection = true
    var userWasRunning = false
    
    var previousAltitude : Double!
    var currentAltitude : Double!
    var averagePace : Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        motionDetector.runningStairsDelegate = self
        motionDetector.startRunningStairsActivity()
        self.runTimer()
    }
    
    @IBAction func stopBtnPressed(_ sender: Any) {
        
        motionDetector.stopRunningStairsActivity()
        timer.invalidate()
        
        // show alert with adding activity to history / or not
        delegate.updateActivityView(index: 0)
    }
    
    // MARK -- RunningStairsProtocol methods
    
    func updateActivityType(activityType: String) {
       
        if activityType == "Walking" || activityType == "Running" {
            userWasRunning = true
        }
    }
    
    func updatePace(pace: Double) {
        
        let intPace = Int(pace.rounded(.toNearestOrAwayFromZero))
        
        if intPace == 0 {
            let paceString = "0" + String(format: "%.2f", pace)
            self.paceLabel.text = paceString
        }
        
        else {
            let paceString = String(format: "%.2f", pace)
            self.paceLabel.text = paceString
        }
    
    }
    
    func updateAveragePace(pace: Double) {
        self.averagePace = pace
    }
    
    func updateAltitude(altitude: Double) {
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
    
    
    func updateFloors(floors:Int) {
        self.floorsButton.setTitle("\(floors)", for: .normal)
    }
    
    func setupDirection() {
        
        // direction is down
        if self.previousAltitude > self.currentAltitude + 0.5 {
            
            let imageDown = UIImage(named: "direction_down")
            directionButton.setImage(imageDown, for: .normal)
            
        }
            
            // direction is up
        else if self.previousAltitude < self.currentAltitude - 0.5 {
            let imageDown = UIImage(named: "direction_up")
            directionButton.setImage(imageDown, for: .normal)
        }
        
        // else don't change direction, leave it as it is because there is not much change in the altitude and you can't know for sure if the user is going up or down
        self.canChangeDirection = true
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    @objc func updateTimer() {
        seconds += 1
        timeLabel.text =  timeString(time: TimeInterval(seconds))
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
