//
//  ViewController1.swift
//  calendar
//
//  Created by thierryH24 on 12/10/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var containerView: NSView!

    let calendarView = THCalendarView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        // Step 1 - Override Style
        
        THCalendarView.globalPreferences.calendar.textColor          = NSColor.darkGray
        THCalendarView.globalPreferences.calendar.cellColorDefault   = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        THCalendarView.globalPreferences.calendar.cellColorToday     = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        THCalendarView.globalPreferences.calendar.borderSelectColor  = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        THCalendarView.globalPreferences.calendar.borderDefaultColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        THCalendarView.globalPreferences.calendar.backgroundColors   = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        THCalendarView.globalPreferences.calendar.beginWeek          = .monday
        
        THCalendarView.globalPreferences.date.circleBackgroundColor  = NSColor.red
        THCalendarView.globalPreferences.date.dotColor               = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        
        // Step 2 - Add calendar to view hierarchy
        addChild(calendarView)
        calendarView.view.frame = containerView.frame
        view.addSubview(calendarView.view)
        print("add View : ", calendarView.view)
        
        setUpLayoutConstraints(item: calendarView.view, toItem: view)

        // Step 3 - Set properties
        // Set selected date
        calendarView.selectedDate = Date()

        // Showing dots
        calendarView.events = generateEvents()
    }
    
    func setUpLayoutConstraints(item : NSView, toItem: NSView) {
        
        item.translatesAutoresizingMaskIntoConstraints = false
        let sourceListLayoutConstraints = [
            NSLayoutConstraint(item: item, attribute: .left, relatedBy: .equal, toItem: toItem, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: item, attribute: .right, relatedBy: .equal, toItem: toItem, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: item, attribute: .top, relatedBy: .equal, toItem: toItem, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: item, attribute: .bottom, relatedBy: .equal, toItem: toItem, attribute: .bottom, multiplier: 1, constant: 100)]
        NSLayoutConstraint.activate(sourceListLayoutConstraints)
    }

    func generateEvents() -> [Int] {
        
        let monthDays = Calendar.current.numberOfDaysInMonthForDate(Date())
        
        let events = (0..<monthDays).map { (i) -> Int in
            let mult : UInt32 = 3
            let val = Double(arc4random_uniform(mult))
            return Int(val)
        }
        return events
    }
    
}
