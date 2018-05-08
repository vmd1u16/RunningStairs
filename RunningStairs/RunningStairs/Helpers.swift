//
//  Helpers.swift
//  RunningStairs
//
//  Created by Vlad on 08/05/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import Foundation

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
