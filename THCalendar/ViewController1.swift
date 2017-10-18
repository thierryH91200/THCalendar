//
//  ViewController1.swift
//  calendar
//
//  Created by thierryH24 on 12/10/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import Cocoa
import SwiftDate

//import EventKit
//
//@objc class CalendarEvent : NSObject {
//    private(set) var title: String
//    private(set) var startDate: Date
//    private(set) var endDate:Date
//    public init(title: String, startDate: Date, endDate: Date) {
//        self.title = title;
//        self.startDate = startDate;
//        self.endDate = endDate;
//    }
//}
//
//extension EKEvent {
//    var isOneDay : Bool {
//        let components = (Calendar.current as NSCalendar).components([.era, .year, .month, .day], from: self.startDate, to: self.endDate, options: NSCalendar.Options())
//        return (components.era == 0 && components.year == 0 && components.month == 0 && components.day == 0)
//    }
//}

class ViewController1: NSViewController {
    
    @IBOutlet weak var toDay: NSButton!
    @IBOutlet weak var nextMonth: NSButton!
    @IBOutlet weak var previous: NSButton!
    
    @IBOutlet weak var containerView: NSView!
    let calendarView = THCalendarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        // Do any additional setup after loading the view.
        
        // Step 1 - Override Style
        var preferences = THCalendarView.Preferences()
        preferences.calendar.backgroundColor = NSColor.systemGray
        preferences.calendar.textColor = NSColor.darkGray
        
        preferences.date.circleBackgroundColor = NSColor.yellow
        preferences.date.dotColor = NSColor.green
        
        THCalendarView.globalPreferences = preferences
        
        // Step 2 - Add calendar to view hierarchy
        addChildViewController(calendarView)
        calendarView.view.frame = containerView.frame
        view.addSubview(calendarView.view)
        
        // Step 3 - Set properties
        // Set selected date
        calendarView.selectedDate = Date(timeIntervalSince1970 : 0)
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
        for i in 0..<Date().monthDays {
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
    
//    // MARK : KDCalendarDataSource
//
//    func startDate() -> Date? {
//
//        var dateComponents = DateComponents()
//        dateComponents.month = -3
//
//        let today = Date()
//
//        let threeMonthsAgo = (self.calendarView.calendar as NSCalendar).date(byAdding: dateComponents, to: today, options: NSCalendar.Options())
//
//        return threeMonthsAgo
//    }
//
//    func endDate() -> Date? {
//
//        var dateComponents = DateComponents()
//
//        dateComponents.year = 2;
//        let today = Date()
//
//        let twoYearsFromNow = (self.calendarView.calendar as NSCalendar).date(byAdding: dateComponents, to: today, options: NSCalendar.Options())
//
//        return twoYearsFromNow
//
//    }
    
//    fileprivate var startOfMonthCache : Date = Date()
//
//
//
//    // MARK : Events
//
//    fileprivate var eventsByIndexPath : [IndexPath:[CalendarEvent]] = [IndexPath:[CalendarEvent]]()
//    var events : [EKEvent]? {
//
//        didSet {
//
//            eventsByIndexPath = [IndexPath:[CalendarEvent]]()
//
//            guard let events = events else {
//                return
//            }
//
//            let secondsFromGMTDifference = TimeInterval(NSTimeZone.local.secondsFromGMT())
//
//            for event in events {
//
//                if event.isOneDay == false {
//                    return
//                }
//
//                let flags: NSCalendar.Unit = [NSCalendar.Unit.month, NSCalendar.Unit.day]
//
//                let startDate = event.startDate.addingTimeInterval(secondsFromGMTDifference)
//                let endDate = event.endDate.addingTimeInterval(secondsFromGMTDifference)
//
//                // Get the distance of the event from the start
//                let distanceFromStartComponent = (self.gregorian as NSCalendar).components( flags, from:startOfMonthCache, to: startDate, options: NSCalendar.Options() )
//
//
//                let calendarEvent = CalendarEvent(title: event.title, startDate: startDate, endDate: endDate)
//
//                let indexPath = IndexPath(item: distanceFromStartComponent.day!, section: distanceFromStartComponent.month!)
//
//                if (eventsByIndexPath[indexPath] != nil) {
//
//                    eventsByIndexPath[indexPath]?.append(calendarEvent)
//
//                } else {
//
//                    eventsByIndexPath[indexPath] = [calendarEvent]
//
//                }
//
//            }
//
//                calendarView.collectionView.reloadData()
//        }
//    }
//
//
////    func loadEventsInCalendar() {
////
////        if let  startDate = self.startDate(),
////            let endDate = self.endDate() {
////
////            let store = EKEventStore()
////            
////            let fetchEvents = { () -> Void in
////                
////                let predicate = store.predicateForEvents(withStart: startDate, end:endDate, calendars: nil)
////                
////                // if can return nil for no events between these dates
////                if let eventsBetweenDates = store.events(matching: predicate) as [EKEvent]? {
////                    self.calendarView.events = eventsBetweenDates
////                }
////
////            }
////
////            // let q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
////
////            if EKEventStore.authorizationStatus(for: EKEntityType.event) != EKAuthorizationStatus.authorized {
////
////                store.requestAccess(to: EKEntityType.event, completion: {(granted, error ) -> Void in
////                    if granted {
////                        fetchEvents()
////                    }
////                })
////                
////            }
////            else {
////                fetchEvents()
////            }
////            
////        }
////
////    }
    

    
    
}
