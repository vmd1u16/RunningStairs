//
//  FirstTrackerViewController.swift
//  RunningStairs
//
//  Created by Vlad on 09/05/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

protocol ActivityChangedProtocol {
    func updateActivityView(index : Int)
}

class FirstTrackerViewController: UIViewController {

    var delegate : ActivityChangedProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func startBtnPressed(_ sender: UIButton) {
        
        self.delegate.updateActivityView(index: 1)
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
