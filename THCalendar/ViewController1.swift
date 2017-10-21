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
        
        preferences.calendar.textColor = NSColor.darkGray
        preferences.calendar.cellColorDefault = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        preferences.calendar.cellColorToday = #colorLiteral(red: 0.996078431372549, green: 0.286274509803922, blue: 0.250980392156863, alpha: 0.3)
        preferences.calendar.borderSelectColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        preferences.calendar.borderDefaultColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        preferences.calendar.backgroundColors = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        preferences.calendar.beginWeek = .monday
        
        preferences.date.circleBackgroundColor = NSColor.red
        preferences.date.dotColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)

        THCalendarView.globalPreferences = preferences
        
        // Step 2 - Add calendar to view hierarchy
        addChildViewController(calendarView)
        calendarView.view.frame = containerView.frame
        view.addSubview(calendarView.view)
        print("add View : ", calendarView.view)
        
        setUpLayoutConstraints(item: calendarView.view, toItem: view)

        // Step 3 - Set properties
        // Set selected date
        calendarView.selectedDate = Date()

        // Showing dots
        calendarView.counts = generateCounts()
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
