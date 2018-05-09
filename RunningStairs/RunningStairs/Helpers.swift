//
//  Helpers.swift
//  RunningStairs
//
//  Created by Vlad on 08/05/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import Foundation
import UIKit

func runCode(in timeInterval:TimeInterval, _ code:@escaping ()->(Void))
{
    DispatchQueue.main.asyncAfter(
        deadline: .now() + timeInterval,
        execute: code)
}

func synchronize(lockObj: AnyObject!, closure: ()->()){
    objc_sync_enter(lockObj)
    closure()
    objc_sync_exit(lockObj)
}

func getDateStringWithFormatFromDate(date : Date, format : String) -> String {

    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US")
    dateFormatter.dateFormat = format 
    
    return dateFormatter.string(from: date)
    
}

func showCustomAlert(title : String , message : String, vc : UIViewController) {
    
    // create the alert
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    
    // add an action (button)
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
    // show the alert
    vc.present(alert, animated: true, completion: nil)
}
