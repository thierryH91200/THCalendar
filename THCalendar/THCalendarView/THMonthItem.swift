//
//  AppDelegate.swift
//  calendar
//
//  Created by thierryH24 on 12/10/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import Cocoa

class THMonthItem: NSCollectionViewItem {

    @IBOutlet weak var monthField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func configure(month: String, year: Int) {
        let month = String(month.prefix(1)).uppercased() + String(month.dropFirst())
        
        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.alignment = .center
        
        var attributesMonth = [NSAttributedStringKey: AnyObject]()
        attributesMonth[.foregroundColor] = NSColor.white
        attributesMonth[.font] = NSFont(name: "Helvetica", size: 20.0)
        attributesMonth[.paragraphStyle] = paragraphStyle
        
        let title = NSMutableAttributedString(string: month, attributes: attributesMonth )
        
        var attributesYear = [NSAttributedStringKey: AnyObject]()
        attributesYear[.foregroundColor] = NSColor.red
        attributesYear[.font] = NSFont(name: "Helvetica", size: 20.0)
        attributesYear[.paragraphStyle] = paragraphStyle

        let yearTitle = NSAttributedString(string: "  \(year)", attributes : attributesYear )

        title.append(yearTitle)
        
        monthField.attributedStringValue = title
        
//        monthField.stringValue = "\(month) \(year)"
//        monthField.textColor = THCalendarView.globalPreferences.calendar.textColor
//        monthField.alignment = .center
//        monthField.font = NSFont(name: "Helvetica", size: 20.0)

    }
    
}
