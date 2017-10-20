//
//  MainWindowController.swift
//  THCalendar
//
//  Created by thierryH24 on 20/10/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController , NSWindowDelegate{
    
    @IBOutlet weak var myView: NSView!

    var delegate: AppDelegate?
    var viewController1      = ViewController1()
    
    var preferences = THCalendarView.globalPreferences

    override func windowDidLoad() {
        super.windowDidLoad()
        
        var  vc = NSView()
        vc = viewController1.view
        
        addSubview(subView: vc, toView: myView)
        
        setUpLayoutConstraints(item: vc, toItem: myView)
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
        preferences.calendar.textColor = color
        THCalendarView.globalPreferences = preferences
        viewController1.calendarView.collectionView.reloadData()
    }
    
    @IBAction func cellColorDefault(_ sender : NSColorWell)
    {
//        var preferences = viewController1.calendarView.pre
        let color = sender.color
        preferences.calendar.cellColorDefault = color
        THCalendarView.globalPreferences = preferences
        viewController1.calendarView.collectionView.reloadData()
    }
    
    @IBAction func cellColorToday(_ sender : NSColorWell)
    {
        let color = sender.color
        print(color)
        preferences.calendar.cellColorToday = color
        THCalendarView.globalPreferences = preferences
        print(THCalendarView.globalPreferences )
        viewController1.calendarView.collectionView.reloadData()
    }

    @IBAction func backgroundColors(_ sender : NSColorWell)
    {
        let color = sender.color
        print(color)

        preferences.calendar.backgroundColors = color
        THCalendarView.globalPreferences = preferences
        viewController1.calendarView.collectionView.backgroundColors =  [color]
        viewController1.calendarView.collectionView.reloadData()
    }




    
}
