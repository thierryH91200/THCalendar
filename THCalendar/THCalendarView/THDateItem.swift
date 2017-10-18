//
//  AppDelegate.swift
//  calendar
//
//  Created by thierryH24 on 12/10/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import Cocoa

let cellColorDefault = NSColor(white: 0.0, alpha: 0.1)
let cellColorToday = NSColor(red: 254.0/255.0, green: 73.0/255.0, blue: 64.0/255.0, alpha: 0.3)
let borderColor = NSColor(red: 254.0/255.0, green: 73.0/255.0, blue: 64.0/255.0, alpha: 0.8)


class THDateItem: NSCollectionViewItem {
    
    //    @IBOutlet weak var itemView: HNDateItemView!
    @IBOutlet weak var dateField: NSTextField!
    
    var circleLayer: CALayer!
    var dotLayer: CALayer!
    var backgroundViewLayer :CALayer!
    
    let preferences = THCalendarView.globalPreferences
    
    var count: Int = 0 {
        didSet {
            dotLayer?.isHidden = count <= 0 ? true : false
        }
    }
    
    override var isSelected: Bool {
        didSet {
            updateStyles()
            backgroundViewLayer.borderWidth = isSelected ? 2.0 : 0.0
        }
    }
    
    var isToday : Bool = false {
        
        didSet {
            backgroundViewLayer.backgroundColor = isToday ? cellColorToday.cgColor : cellColorDefault.cgColor
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
        dateField.stringValue = "\(day)"
        dateField.textColor = THCalendarView.globalPreferences.calendar.textColor
        dateField.alignment = .center
        
        self.inCurrentMonth = inCurrentMonth
        
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
        circleLayer.frame = CGRect( x: 0, y: 0, width: dimension / 2, height: dimension / 2)
        circleLayer.cornerRadius = dimension / 4
        circleLayer.backgroundColor = preferences.date.circleBackgroundColor.cgColor
        circleLayer.masksToBounds = false
        circleLayer.isHidden = true
        
        circleLayer.anchorPoint = CGPoint(x : 0.5, y : 0.5)
        circleLayer.position =  CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)
        view.layer?.addSublayer(circleLayer)
    }
    
    func DotLayer()
    {
        dotLayer = CALayer()
        dotLayer.frame = CGRect(x: 0 , y: 0, width: 4, height: 4)
        dotLayer.cornerRadius = 2
        dotLayer.backgroundColor = preferences.date.dotColor.cgColor
        dotLayer.isHidden = true
        
        dotLayer.anchorPoint = CGPoint(x : 0.5, y : 0.0)
        dotLayer.position =  CGPoint(x: view.bounds.width / 2 , y: 4.0)
        
        view.layer?.addSublayer(dotLayer)
    }
    
    func BackgroundViewLayer() {
        
        backgroundViewLayer = CALayer()
        
        var frame = CGRect( x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        frame = frame.insetBy(dx: 3.0, dy: 3.0)
        
        backgroundViewLayer.frame = frame
        backgroundViewLayer.cornerRadius = 4.0
        
        backgroundViewLayer.borderColor = borderColor.cgColor
        backgroundViewLayer.borderWidth = 0.0
        
        backgroundViewLayer.backgroundColor = cellColorDefault.cgColor
        
        backgroundViewLayer.anchorPoint = CGPoint(x : 0.5, y : 0.5)
        backgroundViewLayer.position =  CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)
        view.layer?.addSublayer(backgroundViewLayer)
    }
    
    private func updateStyles() {
        
        circleLayer.isHidden = !isSelected
    }
}
