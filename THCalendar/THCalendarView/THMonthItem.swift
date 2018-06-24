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

    var attributesMonth = [NSAttributedString.Key: AnyObject]()
    var attributesYear = [NSAttributedString.Key: AnyObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.

        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.alignment = .center

        attributesMonth[NSAttributedString.Key.foregroundColor] = NSColor.white
        attributesMonth[NSAttributedString.Key.font] = NSFont(name: "Helvetica", size: 20.0)
        attributesMonth[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        
        attributesYear[NSAttributedString.Key.foregroundColor] = NSColor.red
        attributesYear[NSAttributedString.Key.font] = NSFont(name: "Helvetica", size: 20.0)
        attributesYear[NSAttributedString.Key.paragraphStyle] = paragraphStyle
    }
    
    func configure(month: String, year: Int) {

        let month = String(month.prefix(1)).uppercased() + String(month.dropFirst())
        let title = NSMutableAttributedString(string: month, attributes: attributesMonth )
        let yearTitle = NSAttributedString(string: "  \(year)", attributes : attributesYear )

        title.append(yearTitle)
        
        monthField.attributedStringValue = title
    }
    
}
