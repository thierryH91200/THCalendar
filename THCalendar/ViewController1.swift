//
//  ViewController1.swift
//  calendar
//
//  Created by thierryH24 on 12/10/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import Cocoa

class ViewController1: NSViewController {
    
    @IBOutlet weak var toDay: NSButton!
    @IBOutlet weak var nextMonth: NSButton!
    @IBOutlet weak var previous: NSButton!
    
    @IBOutlet weak var containerView: NSView!
    
    let calendarView = THCalendarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        // Step 1 - Override Style
        var preferences = THCalendarView.globalPreferences
        
        preferences.calendar.textColor = NSColor.darkGray
        preferences.calendar.cellColorDefault = NSColor(white: 0.0, alpha: 0.1)
        preferences.calendar.cellColorToday = #colorLiteral(red: 0.996078431372549, green: 0.286274509803922, blue: 0.250980392156863, alpha: 0.3)
        preferences.calendar.borderColor = #colorLiteral(red: 0.996078431372549, green: 0.286274509803922, blue: 0.250980392156863, alpha: 0.8)
        preferences.calendar.backgroundColors = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        preferences.calendar.beginWeek = .monday
        
        preferences.date.circleBackgroundColor = NSColor.yellow
        preferences.date.dotColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)

        THCalendarView.globalPreferences = preferences
        
        // Step 2 - Add calendar to view hierarchy
        addChildViewController(calendarView)
        calendarView.view.frame = containerView.frame
        view.addSubview(calendarView.view)
        
        // Step 3 - Set properties
        // Set selected date
        calendarView.selectedDate = Date()

        // Showing dots
        calendarView.counts = generateCounts()
        
        var attributes = [NSAttributedStringKey: AnyObject]()
        attributes[NSAttributedStringKey.foregroundColor] = NSColor.blue
        
        var attributedString = NSAttributedString(string: "Previous month", attributes: attributes)
        previous.attributedTitle = attributedString
        
        attributedString = NSAttributedString(string: "Next month", attributes: attributes)
        nextMonth.attributedTitle = attributedString
        
        attributedString = NSAttributedString(string: "Today", attributes: attributes)
        toDay.attributedTitle = attributedString
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
    
    @IBAction func previousMonth(_ sender: Any) {
        goToMonthWithOffet(-1)
    }
    
    @IBAction func toDayMonth(_ sender: Any) {
        
        calendarView.date = Date()
        calendarView.selectedDate = Date()
        
        calendarView.collectionView.reloadData()
    }
    
    @IBAction func nextMonth(_ sender: Any) {
        goToMonthWithOffet(1)
    }
    func goToMonthWithOffet(_ offet:Int){
        
        if let newDate = (calendarView.date.applyOffSetOfMonth( offset: offet)){
            calendarView.date = newDate
            calendarView.selectedDate = newDate

            calendarView.collectionView.reloadData()
        }
    }
}
