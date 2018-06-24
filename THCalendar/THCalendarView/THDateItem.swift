//
//  AppDelegate.swift
//  calendar
//
//  Created by thierryH24 on 12/10/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import Cocoa

class THDateItem: NSCollectionViewItem {
    
    @IBOutlet weak var dateField: NSTextField!
    
    var circleLayer: CALayer?
    var dotLayer: CALayer?
    var backgroundViewLayer : CALayer?
    
    let preferences = THCalendarView.globalPreferences
    
    var event: Int = 0 {
        didSet {
            dotLayer?.isHidden = event > 0 ? false : true
        }
    }
    
    override var isSelected: Bool {
        didSet {
            guard backgroundViewLayer?.isHidden != true else { return }
            
            updateStyles()
            backgroundViewLayer?.borderWidth = isSelected ? 2.0 : 1.0
            
            let borderSelectColor = THCalendarView.globalPreferences.calendar.borderSelectColor.cgColor
            let borderDefaultColor = THCalendarView.globalPreferences.calendar.borderDefaultColor.cgColor
            backgroundViewLayer?.borderColor = isSelected ? borderSelectColor: borderDefaultColor
            
//            backgroundViewLayer?.shadowColor = NSColor.black.cgColor
//            backgroundViewLayer?.shadowOffset = NSMakeSize(0.5, 0.4)
//            backgroundViewLayer?.shadowRadius = 5.0
//            backgroundViewLayer?.shadowOpacity = 0.50

            if isSelected == true {
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .none
                let strDate = dateFormatter.string(from: dateItem)
                
                print("Date : \(strDate), for Event : \(event)")
            }
        }
    }
    
    var dateItem : Date  = Date() {
        didSet {
//            print(dateItem)
        }
    }
    
    var isHidden : Bool = false {
        didSet {
            if isHidden == true && inCurrentMonth == false {
                dateField.isHidden = isHidden
                circleLayer?.isHidden = isHidden
                dotLayer?.isHidden = isHidden
                backgroundViewLayer?.isHidden = isHidden
            }
        }
    }
    
    var isToday : Bool = false {
        
        didSet {
            let cellColorToday = THCalendarView.globalPreferences.calendar.cellColorToday.cgColor
            let cellColorDefault = THCalendarView.globalPreferences.calendar.cellColorDefault.cgColor
            backgroundViewLayer?.backgroundColor = isToday ? cellColorToday : cellColorDefault
        }
    }
    
    var inCurrentMonth: Bool = true {
        didSet {
            dateField.alphaValue = inCurrentMonth ? 1.0 : 0.3
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func configure(day: Int, inCurrentMonth: Bool) {
        
        self.inCurrentMonth = inCurrentMonth
        
        dateField.stringValue = "\(day)"
        dateField.textColor = preferences.calendar.textColor
        dateField.alignment = .center
        dateField.isHidden = false

        view.wantsLayer = true
        view.layer?.sublayers?.forEach { $0.removeFromSuperlayer() }
        
        BackgroundViewLayer()
        CircleLayer()
        DotLayer()
    }
    
    func CircleLayer()
    {
        view.wantsLayer = true
        
        circleLayer = CALayer()
        let dimension = min(view.bounds.width, view.bounds.height)
        circleLayer?.frame = CGRect( x: 0, y: 0, width: dimension / 2, height: dimension / 2)
        circleLayer?.cornerRadius = dimension / 4
        circleLayer?.backgroundColor = preferences.date.circleBackgroundColor.cgColor
        circleLayer?.masksToBounds = false
        circleLayer?.isHidden = true
        
        circleLayer?.anchorPoint = CGPoint(x : 0.5, y : 0.5)
        circleLayer?.position =  CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)
        view.layer?.addSublayer(circleLayer!)
    }
    
    func DotLayer()
    {
        dotLayer = CALayer()
        dotLayer?.frame = CGRect(x: 0 , y: 0, width: 4, height: 4)
        dotLayer?.cornerRadius = 2
        dotLayer?.backgroundColor = preferences.date.dotColor.cgColor
        dotLayer?.isHidden = true
        
        dotLayer?.anchorPoint = CGPoint(x : 0.5, y : 0.0)
        dotLayer?.position =  CGPoint(x: view.bounds.width / 2 , y: 6.0)
        
        view.layer?.addSublayer(dotLayer!)
    }
    
    func BackgroundViewLayer() {
        
        backgroundViewLayer = CALayer()
        
        var frame = CGRect( x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        frame = frame.insetBy(dx: 3.0, dy: 3.0)
        
        backgroundViewLayer?.frame = frame
        backgroundViewLayer?.cornerRadius = 0                   //4.0
        backgroundViewLayer?.backgroundColor = THCalendarView.globalPreferences.calendar.cellColorDefault.cgColor
        
        backgroundViewLayer?.borderColor = THCalendarView.globalPreferences.calendar.borderDefaultColor.cgColor
        backgroundViewLayer?.borderWidth = 1.0
                
        backgroundViewLayer?.anchorPoint = CGPoint(x : 0.5, y : 0.5)
        backgroundViewLayer?.position =  CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)
        view.layer?.addSublayer(backgroundViewLayer!)
    }
    
    private func updateStyles() {
        
        circleLayer?.isHidden = !isSelected
    }
    
}
