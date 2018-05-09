//
//  HistoryTableViewController.swift
//  RunningStairs
//
//  Created by Vlad on 09/05/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit
import CoreData

class HistoryTableViewController: UITableViewController {
    
    
    var activities = [Activity]()
    
    // loading view
    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var loadingView: UIView = UIView()

    var managedObjectContext:NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        
        self.setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.showActivityIndicator()
        self.fetchActivitiesFromLocalDB(completionHandler: {(completed) -> Void in
            
                self.hideActivityIndicator()
                self.tableView.reloadData()
            
        })
    }
    
    func setupNavigationBar() {
        
        self.navigationItem.title = "Activity history"
        let attributes = [NSAttributedStringKey.font : UIFont(name: "Helvetica Neue", size: 22)!, NSAttributedStringKey.foregroundColor : UIColor.white
        ]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 233/255, green: 74/255, blue: 41/255, alpha: 1.0)
        
    }
    
    
    
    func fetchActivitiesFromLocalDB(completionHandler: @escaping (_ completed: Bool?) -> ()) {
        
        let request = Activity.createFetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "startDate", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            self.activities = try managedObjectContext.fetch(request)
            
            completionHandler(true)
            
        }
        catch {
            print("Could not load data \(error.localizedDescription) ")
            completionHandler(false)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as! ActivityTableViewCell

        cell.setupActivity(activity: activities[indexPath.row])
        cell.setupViews()

        return cell
    }
 

    func showActivityIndicator() {
        DispatchQueue.main.async {
            
            self.loadingView = UIView()
            self.loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0)
            self.loadingView.center = self.view.center
            self.loadingView.backgroundColor = UIColor.clear
            self.loadingView.alpha = 0.7
            self.loadingView.clipsToBounds = true
            self.loadingView.layer.cornerRadius = 10
            
            self.spinner.color = UIColor.red
            self.spinner.frame = CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0)
            self.spinner.center = CGPoint(x:self.loadingView.bounds.size.width / 2, y:self.loadingView.bounds.size.height / 2)
            
            self.loadingView.addSubview(self.spinner)
            self.view.addSubview(self.loadingView)
            self.spinner.startAnimating()
            
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.loadingView.removeFromSuperview()        }
    }
    

}
