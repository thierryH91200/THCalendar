//
//  MainWindowController.swift
//  THCalendar
//
//  Created by thierryH24 on 20/10/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController , NSWindowDelegate {

    @IBOutlet weak var myView: NSView!
    
    @IBOutlet weak var backgroundColors: NSColorWell!
    @IBOutlet weak var borderDefaultColor: NSColorWell!
    @IBOutlet weak var borderSelectColor: NSColorWell!
    @IBOutlet weak var cellColor: NSColorWell!
    @IBOutlet weak var cellColorToday: NSColorWell!
    @IBOutlet weak var colorText: NSColorWell!
    @IBOutlet weak var hideShowCell: NSButton!
    
    @IBOutlet weak var weekPop: NSPopUpButton!
    
    var delegate: AppDelegate?
    var viewController      = ViewController()
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        var  vc = NSView()
        vc = viewController.view
        
        addSubview(subView: vc, toView: myView)
        
        setUpLayoutConstraints(item: vc, toItem: myView)
        
        backgroundColors.color   = THCalendarView.globalPreferences.calendar.backgroundColors
        borderDefaultColor.color = THCalendarView.globalPreferences.calendar.borderDefaultColor
        borderSelectColor.color  = THCalendarView.globalPreferences.calendar.borderSelectColor
        cellColor.color          = THCalendarView.globalPreferences.calendar.cellColorDefault
        cellColorToday.color     = THCalendarView.globalPreferences.calendar.cellColorToday
        colorText.color          = THCalendarView.globalPreferences.calendar.textColor
        hideShowCell.state       = THCalendarView.globalPreferences.calendar.isHidden == true ? .on : .off
    }
    
    func addSubview(subView:NSView, toView parentView : NSView)
    {
        let myView = parentView.subviews
        if myView.count > 0
        {
            parentView.replaceSubview(myView[0], with: subView)
            print("replace View : ", subView)
        }
        else
        {
            parentView.addSubview(subView)
            print("add View : ", subView)
        }
    }
    
    func setUpLayoutConstraints(item : NSView, toItem: NSView)
    {
        item.translatesAutoresizingMaskIntoConstraints = false
        let sourceListLayoutConstraints = [
            NSLayoutConstraint(item: item, attribute: .left, relatedBy: .equal, toItem: toItem, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: item, attribute: .right, relatedBy: .equal, toItem: toItem, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: item, attribute: .top, relatedBy: .equal, toItem: toItem, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: item, attribute: .bottom, relatedBy: .equal, toItem: toItem, attribute: .bottom, multiplier: 1, constant: 0)]
        NSLayoutConstraint.activate(sourceListLayoutConstraints)
    }
    
    @IBAction func changeColorText(_ sender : NSColorWell)
    {
        let color = sender.color
        THCalendarView.globalPreferences.calendar.textColor = color
        viewController.calendarView.collectionView.reloadData()
    }
    
    @IBAction func changeBackgroundColors(_ sender : NSColorWell)
    {
        let color = sender.color
        THCalendarView.globalPreferences.calendar.backgroundColors = color
        viewController.calendarView.collectionView.backgroundColors =  [color]
        viewController.calendarView.collectionView.reloadData()
    }
    
    @IBAction func changeCellColor(_ sender : NSColorWell)
    {
        let color = sender.color
        THCalendarView.globalPreferences.calendar.cellColorDefault = color
        viewController.calendarView.collectionView.reloadData()
    }
    
    @IBAction func changeCellColorToday(_ sender : NSColorWell)
    {
        let color = sender.color
        THCalendarView.globalPreferences.calendar.cellColorToday = color
        viewController.calendarView.collectionView.reloadData()
    }
    
    @IBAction func changeBorderDefaultColor(_ sender : NSColorWell)
    {
        let color = sender.color
        THCalendarView.globalPreferences.calendar.borderDefaultColor = color
        viewController.calendarView.collectionView.reloadData()
    }
    
    @IBAction func changeBorderSelectColor(_ sender : NSColorWell)
    {
        let color = sender.color
        THCalendarView.globalPreferences.calendar.borderSelectColor = color
        viewController.calendarView.collectionView.reloadData()
    }
    
    @IBAction func changeBeginWeek(_ sender : Any)
    {
        let menuItem =  weekPop.indexOfSelectedItem == 6 ? weekPop.indexOfSelectedItem : 5 - weekPop.indexOfSelectedItem
        THCalendarView.globalPreferences.calendar.beginWeek = THCalendarView.weekDisplay(rawValue: menuItem)!
        viewController.calendarView.collectionView.reloadData()
    }
    
    @IBAction func changeHideCell(_ sender: NSButton) {
        
        let check = sender.state == .on
        THCalendarView.globalPreferences.calendar.isHidden = check
        viewController.calendarView.collectionView.reloadData()
    }
}
