//
//  ActivityTableViewCell.swift
//  RunningStairs
//
//  Created by Vlad on 09/05/2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    var activity : Activity!
    
    var runnerImageView: UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "history-runningman")!
        return imageView
    }()
    
    var timeLabel : UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica Neue", size: 14.0)
        label.textColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1.0)
        label.text = "on 08.05.2018 ● from 15:01 to 15:25"
        
        return label
        
    }()
    
    var statsLabel : UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica Neue", size: 14.0)
        label.textColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1.0)
        label.text = "pace 05:12 s/m ● 12 floors"
        
        return label
        
    }()
    
    func setupViews() {
        
        self.contentView.addSubview(runnerImageView)
        self.contentView.addSubview(timeLabel)
        self.contentView.addSubview(statsLabel)
        
        // time label
        
        let startDateF = getDateStringWithFormatFromDate(date: self.activity.startDate! as Date, format: "dd.MM.yyyy")
        let startDateS = getDateStringWithFormatFromDate(date: self.activity.startDate! as Date, format: "HH:mm:ss")
        let endDateS = getDateStringWithFormatFromDate(date: self.activity.endDate! as Date, format: "HH:mm:ss")
        
        self.timeLabel.text = "on \(startDateF) ● from \(startDateS) to \(endDateS)"
        
        // stats label
        
        let intPace = Int(self.activity.pace.rounded(.toNearestOrAwayFromZero))

        if intPace == 0 {
            let paceString = "0" + String(format: "%.2f", self.activity.pace)
            self.statsLabel.text = "pace \(paceString) s/m ● \(self.activity.floors) floors"
        }
            
        else {
            let paceString = String(format: "%.2f", self.activity.pace)
            self.statsLabel.text = "pace \(paceString) s/m ● \(self.activity.floors) floors"
        }
        
        
        // set data from activity model
        
        setConstraints()
        
    }
    
    func setupActivity(activity : Activity) {
        self.activity = activity
    }
    
    func setConstraints() {
        
        
        var leftConstraint = NSLayoutConstraint(item: runnerImageView, attribute: NSLayoutAttribute.leading, relatedBy: .equal, toItem: self.contentView,
                                                attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 12)
        
        let topConstraint = NSLayoutConstraint(item: runnerImageView, attribute: NSLayoutAttribute.top, relatedBy: .equal, toItem: self.contentView,
                                               attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 12)
        
        
        
        
        let widthConstraint = NSLayoutConstraint(item: runnerImageView, attribute: .width, relatedBy: .equal,
                                                 toItem: self.contentView, attribute: .width,
                                                 multiplier: 0.15, constant: 0.0)
        
        self.contentView.addConstraints([leftConstraint, topConstraint, widthConstraint])
        
        // ad thumbnail image
        
        let aspectRatioConstraint = NSLayoutConstraint(item: runnerImageView,
                                                       attribute: .height,
                                                       relatedBy: .equal,
                                                       toItem: runnerImageView,
                                                       attribute: .width,
                                                       multiplier: (1.0),
                                                       constant: 0)
        
        
        runnerImageView.addConstraint(aspectRatioConstraint)
        
        
       // time label
        
        leftConstraint = NSLayoutConstraint(item: timeLabel, attribute: NSLayoutAttribute.leading, relatedBy: .equal, toItem: self.runnerImageView, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 8)
        
        var yConstraint = NSLayoutConstraint(item: timeLabel, attribute: NSLayoutAttribute.centerY, relatedBy: .equal, toItem: self.runnerImageView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: -12)
        
       var rightConstraint = NSLayoutConstraint(item: timeLabel, attribute: NSLayoutAttribute.trailing, relatedBy: .equal, toItem: self.contentView, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: -12)
        
        self.contentView.addConstraints([leftConstraint, yConstraint, rightConstraint])
        

        // stats label
        
        leftConstraint = NSLayoutConstraint(item: statsLabel, attribute: NSLayoutAttribute.leading, relatedBy: .equal, toItem: self.timeLabel, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0)
        
        yConstraint = NSLayoutConstraint(item: statsLabel, attribute: NSLayoutAttribute.centerY, relatedBy: .equal, toItem: self.runnerImageView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 12)
        
        rightConstraint = NSLayoutConstraint(item: statsLabel, attribute: NSLayoutAttribute.trailing, relatedBy: .equal, toItem: self.contentView, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: -12)
        
        let bottomConstraint = NSLayoutConstraint(item: statsLabel, attribute: NSLayoutAttribute.bottom, relatedBy: .equal, toItem: self.contentView,
                                                  attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: -12)
        
        self.contentView.addConstraints([leftConstraint, yConstraint, rightConstraint,bottomConstraint])
        
        
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
