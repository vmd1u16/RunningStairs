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
    
    @IBOutlet weak var stairsCounter: UILabel!
    
    @IBOutlet weak var altitudeLabel: UILabel!
    
    @IBOutlet weak var accelerationZLabel: UILabel!
    
    @IBOutlet weak var floorsUpLabel: UILabel!
    
    @IBOutlet weak var floorsDownLabel: UILabel!
    
    
    let motionDetector = MotionDetector()
    
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
    
    func updateStairsCount(count: String) {
        self.stairsCounter.text = count
    }
    
    func updateAltitude(altitude: String?) {
        self.altitudeLabel.text = altitude
    }
    
    func updateAccelerationZ(accelerationZ: String) {
        self.accelerationZLabel.text = accelerationZ
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

