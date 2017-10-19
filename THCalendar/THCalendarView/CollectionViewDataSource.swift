//
//  AppDelegate.swift
//  calendar
//
//  Created by thierryH24 on 12/10/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import Foundation
import Cocoa

extension THCalendarView: NSCollectionViewDataSource {
    
    func numberOfSections(in: NSCollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch Section(rawValue: section)! {
        case .month:
            return 1
        case .week:
            return 7
        case .date:
            return 7 * 6
        }
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        var item: NSCollectionViewItem
        let calendar = Calendar.current

        switch Section(rawValue: indexPath.section)! {
        case .month:
            item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "THMonthItem"), for: indexPath)
            
            if let item = item as? THMonthItem {
                item.configure(month: THCalendar.Month[calendar.month(date) - 1], year: calendar.year(date))
            }
        case .week:
            item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "THWeekItem"), for: indexPath)
            
            if let item = item as? THWeekItem {
                let beginWeek = THCalendarView.globalPreferences.calendar.beginWeek.rawValue
                let begin = 6 - beginWeek
                let formatter = DateFormatter()
                var index = indexPath.item + begin
                if index >= 7 {
                    index  = index - 7
                }
                let day = formatter.weekdaySymbols[index]
                item.configure(week: day)
            }
        case .date:
            
            let (day, inMonth) = dayInMonthForItem(item: indexPath.item)
            item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "THDateItem"), for: indexPath)
            
            if let item = item as? THDateItem {
                var beginWeek = THCalendarView.globalPreferences.calendar.beginWeek.rawValue + 1
                if beginWeek  == 7
                {
                    beginWeek = 0
                }
                item.configure(day: day, inCurrentMonth: inMonth)
                
                if let counts = counts, inMonth {
                    item.count = counts[day - 1]
                } else {
                    item.count = 0
                }
                let index = indexPathForDate(selectedDate: selectedDate)
                let month = THCalendar.Month[calendar.month(date) - 1]
                let monthSelect = THCalendar.Month[calendar.month(Date()) - 1]
                if indexPath.item == (index?.item)! + beginWeek && month ==  monthSelect {
                    item.isToday = true
                } else
                {
                    item.isToday = false
                }
            }
        }
        return item
    }
    
    // MARK: - Private
    private func dayInMonthForItem(item: Int) -> (Int, Bool) {
        
        var day: Int = 0
        var inMonth = false
        
        let beginWeek = THCalendarView.globalPreferences.calendar.beginWeek.rawValue

        let calendar = Calendar.current

        let start = date.startOfMonth()
        var weekDay = calendar.component(.weekday, from: start) + beginWeek
        
        let monthDays = calendar.numberOfDaysInMonthForDate(date)

        weekDay = weekDay >= 7 ? weekDay - 7 : weekDay

        // Previous month
        if item < weekDay
        {
            let day2 = calendar.prevStartOfMonthForDate(date)
            let day1 = calendar.numberOfDaysInMonthForDate(day2)
            
            let day3 = dayForItem(item: item, weekDay: weekDay)

            day = day3 + day1
        }
        else
        {
            // Current month
            if item - weekDay - 1 < monthDays - 1
            {
                day = dayForItem(item: item, weekDay: weekDay)
                inMonth = true
            }
            else
            {
                // Next month
                day = dayForItem(item: item, weekDay: weekDay) - monthDays
            }
        }
        return (day, inMonth)
    }
    
    private func dayForItem(item: Int, weekDay: Int) -> Int {
        let day = item - weekDay + 1
        return day
    }
}

extension Date {
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
}

