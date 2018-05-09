//
//  TabBarViewController.swift
//  RunningStairs
//
//  Created by Vlad on 09/05/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

class TabBarViewController: UIViewController, ActivityChangedProtocol {

    @IBOutlet weak var containerView: UIView!
    
    private lazy var firstTrackerViewController: FirstTrackerViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "firstTrackerViewC") as! FirstTrackerViewController
        viewController.delegate = self
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var secondTrackerViewController: SecondTrackerViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "secondTrackerViewC") as! SecondTrackerViewController
        viewController.delegate = self
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateView(selectedIndex: 0)
        self.setupNavigationBar()
    }
    
    func setupNavigationBar() {
        
        self.navigationItem.title = "Activity tracker"
        let attributes = [NSAttributedStringKey.font : UIFont(name: "Helvetica Neue", size: 22)!, NSAttributedStringKey.foregroundColor : UIColor.white
        ]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 233/255, green: 74/255, blue: 41/255, alpha: 1.0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    private func updateView(selectedIndex : Int) {
        if selectedIndex == 0 {
            remove(asChildViewController: secondTrackerViewController)
            add(asChildViewController: firstTrackerViewController)
        } else {
            remove(asChildViewController: firstTrackerViewController)
            add(asChildViewController: secondTrackerViewController)
        }
    }
    
    func addSubview(subView:UIView, toView parentView:UIView) {
        parentView.addSubview(subView)
        
        var viewBindingsDict = [String: AnyObject]()
        viewBindingsDict["subView"] = subView
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subView]|",
                                                                 options: [], metrics: nil, views: viewBindingsDict))
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subView]|",
                                                                 options: [], metrics: nil, views: viewBindingsDict))
    }

    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        containerView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }
    
    // MARK - activity changed protocol methods
    
    func updateActivityView(index: Int) {
        updateView(selectedIndex: index)
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    }
 

}
