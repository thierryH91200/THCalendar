//
//  ViewController1.swift
//  calendar
//
//  Created by thierryH24 on 12/10/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import Cocoa

class ViewController1: NSViewController {
    
    @IBOutlet weak var containerView: NSView!
    
    let calendarView = THCalendarView()
    var preferences = THCalendarView.globalPreferences

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        // Step 1 - Override Style
//        var preferences = THCalendarView.globalPreferences
        
        preferences.calendar.textColor = NSColor.darkGray
        preferences.calendar.cellColorDefault = NSColor(white: 0.0, alpha: 0.1)
        preferences.calendar.cellColorToday = #colorLiteral(red: 0.996078431372549, green: 0.286274509803922, blue: 0.250980392156863, alpha: 0.3)
        preferences.calendar.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        preferences.calendar.backgroundColors = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        preferences.calendar.beginWeek = .monday
        
        preferences.date.circleBackgroundColor = NSColor.yellow
        preferences.date.dotColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)

        THCalendarView.globalPreferences = preferences
        
        // Step 2 - Add calendar to view hierarchy
        addChildViewController(calendarView)
        calendarView.view.frame = containerView.frame
        view.addSubview(calendarView.view)
        setUpLayoutConstraints(item: calendarView.view, toItem: view)

        // Step 3 - Set properties
        // Set selected date
        calendarView.selectedDate = Date()

        // Showing dots
        calendarView.counts = generateCounts()
    }
    
    func setBorderColor(color :NSColor)
    {
        preferences.calendar.borderColor =  color
        THCalendarView.globalPreferences = preferences
        calendarView.collectionView.reloadData()
    }
    
    func setUpLayoutConstraints(item : NSView, toItem: NSView)
    {
        item.translatesAutoresizingMaskIntoConstraints = false
        let sourceListLayoutConstraints = [
            NSLayoutConstraint(item: item, attribute: .left, relatedBy: .equal, toItem: toItem, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: item, attribute: .right, relatedBy: .equal, toItem: toItem, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: item, attribute: .top, relatedBy: .equal, toItem: toItem, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: item, attribute: .bottom, relatedBy: .equal, toItem: toItem, attribute: .bottom, multiplier: 1, constant: 100)]
        NSLayoutConstraint.activate(sourceListLayoutConstraints)
    }

    
    func generateCounts() -> [Int] {
        
        var counts = [Int]()
        let calendar = Calendar.current

        let monthDays = calendar.numberOfDaysInMonthForDate(Date())
        for i in 0..<monthDays {
            counts.append(i % 2)
        }
        return counts
    }
}
