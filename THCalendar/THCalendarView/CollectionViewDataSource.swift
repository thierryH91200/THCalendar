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
        
        switch Section(rawValue: indexPath.section)! {
        case .month:
            item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "THMonthItem"), for: indexPath)
            
            if let item = item as? THMonthItem {
                item.configure(month: THCalendar.Month[date.month - 1], year: date.year)
            }
        case .week:
            item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "THWeekItem"), for: indexPath)
            
            if let item = item as? THWeekItem {
//                let week = HNCalendar.Week[indexPath.item]
                let formatter = DateFormatter()
                var index = indexPath.item + 1
                if index == 7 {
                    index  = 0
                }
                let day = formatter.weekdaySymbols[index]
                item.configure(week: day)
            }
        case .date:
            
            let (day, inMonth) = dayInMonthForItem(item: indexPath.item)
            item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "THDateItem"), for: indexPath)
            
            if let item = item as? THDateItem {
                item.configure(day: day, inCurrentMonth: inMonth)
                
                if let counts = counts, inMonth {
                    item.count = counts[day - 1]
                } else {
                    item.count = 0
                }
                let index = indexPathForDate(selectedDate: selectedDate)
                let month = THCalendar.Month[date.month - 1]
                let monthSelect = THCalendar.Month[Date().month - 1]
                if indexPath.item == (index?.item)! + 6 && month ==  monthSelect {
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
        
        let weekDay = date.startOf(component: .month).weekday
        let monthDays = date.monthDays
        
        if item < weekDay + 5
        {
            let day1 = (1.months.from(date: date)?.monthDays)!
            day = dayForItem(item: item) + day1
        }
        else
        {
            if item - weekDay - 6 < monthDays - 1
            {
                day = dayForItem(item: item)
                inMonth = true
            }
            else
            {
                day = dayForItem(item: item) - monthDays
            }
        }
        return (day, inMonth)
    }
    
    private func dayForItem(item: Int) -> Int {
        let day = item - date.startOf(component: .month).weekday - 4
        return day
    }
}
