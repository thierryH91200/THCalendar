//
//  AppDelegate.swift
//  calendar
//
//  Created by thierryH24 on 12/10/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import Cocoa

class THWeekItem: NSCollectionViewItem {

    @IBOutlet weak var weekField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func configure(week: String) {
        weekField.stringValue = String(week.prefix(1)).uppercased() + String(week.dropFirst())
        weekField.textColor = THCalendarView.globalPreferences.calendar.textColor
        weekField.alignment = .right
    }
    
}
