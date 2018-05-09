//
//  SecondTrackerViewController.swift
//  RunningStairs
//
//  Created by Vlad on 09/05/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit
import MotionDetector
import CoreData

class SecondTrackerViewController: UIViewController, RunningStairsProtocol {

    
    @IBOutlet weak var directionButton: UIButton!
    
    @IBOutlet weak var floorsButton: UIButton!
    
    @IBOutlet weak var paceLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    var seconds = 0
    var timer = Timer()
    
    var managedObjectContext:NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var delegate : ActivityChangedProtocol!
    
    let motionDetector = MotionDetector()
    
    var canChangeDirection = true
    var userWasRunning = false
    
    var floors = 0
    var previousAltitude : Double!
    var currentAltitude : Double!
    var averagePace = 0.0
    var startDate : NSDate!
    var endDate : NSDate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        startDate = NSDate()
        setupInitialViews()
        
        motionDetector.runningStairsDelegate = self
        motionDetector.startRunningStairsActivity()
        
        self.runTimer()
    }
    
    @IBAction func stopBtnPressed(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
            actionSheet.addAction(UIAlertAction(title: "Save Activity", style: .default, handler: { (action: UIAlertAction!) in
                
                self.saveActivity()
            }))
        
        
        actionSheet.addAction(UIAlertAction(title: "Resume", style: .default, handler: { (action: UIAlertAction!) in
            
                // nothing to be done
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Restart", style: .destructive, handler: { (action: UIAlertAction!) in
            self.restartActivity()
            
        }))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    func saveActivity() {
        
        guard userWasRunning == true else {
            
            showCustomAlert(title: "Activity cannot be saved.", message: "You were not running during this activity!", vc: self)
        
            return
        }
        
        self.endDate = NSDate()
        
        let activity = Activity(context: managedObjectContext)
        activity.startDate = self.startDate
        activity.endDate = self.endDate
        activity.pace = self.averagePace
        activity.duration = Int64(self.seconds)
        activity.floors = Int64(self.floors)
        
        
        // try to save activity to db
        do {
            try self.managedObjectContext.save()
        }
        catch {
            print ("Could not save data \(error.localizedDescription)")
        }
        
        showCustomAlert(title: "Activity was saved.", message: "", vc: self)
        
        self.restartActivity()
    }
    
    func restartActivity() {
        
        setupInitialViews()
        self.motionDetector.stopRunningStairsActivity()
        self.self.timer.invalidate()
        
        self.delegate.updateActivityView(index: 0)
        
    }
    
    func setupInitialViews() {
        
        directionButton.setImage(nil, for: .normal)
        
        floorsButton.setTitle("0", for: .normal)
        
        paceLabel.text = "--:--"
        self.seconds = 0
        timeLabel.text = "00:00:00"
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
                runCode(in: 3.0) {
                    
                    self.setupDirection()
                    
                }
            }
        }
    }
    
    
    func updateFloors(floors:Int) {
        self.floorsButton.setTitle("\(floors)", for: .normal)
        self.floors = floors
    }
    
    func setupDirection() {
        
        // direction is down
        if self.previousAltitude > self.currentAltitude + 0.35 {
            
            let imageDown = UIImage(named: "direction_down")
            directionButton.setImage(imageDown, for: .normal)
            
        }
            
            // direction is up
        else if self.previousAltitude < self.currentAltitude - 0.35 {
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
