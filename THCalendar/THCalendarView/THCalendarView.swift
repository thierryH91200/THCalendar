//
//  AppDelegate.swift
//  calendar
//
//  Created by thierryH24 on 12/10/2017.
//  Copyright © 2017 thierryH24. All rights reserved.
//

import Cocoa


class THCalendarView: NSViewController {
    
    @IBOutlet weak var collectionView: NSCollectionView!

    public struct Preferences {
        
        public struct Calendar {
            public var textColor = NSColor.black
            public var cellColorDefault = NSColor(white: 0.0, alpha: 0.1)
            public var cellColorToday = #colorLiteral(red: 0.996078431372549, green: 0.286274509803922, blue: 0.250980392156863, alpha: 0.3)
            public var borderColor = #colorLiteral(red: 0.996078431372549, green: 0.286274509803922, blue: 0.250980392156863, alpha: 0.8)
            public var backgroundColors = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        }
        
        public struct Date {
            public var circleBackgroundColor = NSColor.red
            public var dotColor = NSColor.blue
        }
        
        var calendar = Calendar()
        var date = Date()
        
        public init() {}
    }
    
    public static var globalPreferences = Preferences()
    
    // Today
    var date = Date()
    // Selected Date
    public var selectedDate: Date = Date() {
        didSet {
            selectSelectedDateItem()
        }
    }
    
    public var counts: [Int]?
    
    enum Section: Int {
        case month = 0, week, date
    }
    
    public init() {
        super.init(nibName: NSNib.Name(rawValue: "THCalendarView"), bundle: Bundle(for: THCalendarView.self))
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        let colorBackGround = THCalendarView.globalPreferences.calendar.backgroundColors
        collectionView.backgroundColors =  [colorBackGround]

    }
        
    func selectSelectedDateItem() {
//        if let selectedIndexPath = indexPathForDate(selectedDate: selectedDate) {
//            collectionView?.selectItems(at: [selectedIndexPath ], scrollPosition: [.top])
//        }
    }
    
    func indexPathForDate(selectedDate: Date) -> IndexPath? {
        
        
        if date.month == selectedDate.month {
            let item = date.startOf(component: .month).weekday + selectedDate.day - 2
            let index = IndexPath(item: item, section: Section.date.rawValue)
            return index
        }
        return nil
    }
}

extension THCalendarView: NSCollectionViewDelegate {
    
}

extension THCalendarView: NSCollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        
        let width = collectionView.bounds.width
        var size = NSSize()
        
        switch Section(rawValue: indexPath.section)! {
        case .month:
            size =  NSMakeSize(width, 50)
        case .week:
            size = NSMakeSize(width / 7, 30)
        case .date:
            size = NSMakeSize(width / 7, 50 )
        }
        return size
    }
    
    public func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0
    }
}

extension Date {
    
    func applyOffSetOfMonth( offset:Int) -> Date? {
        
        var dateComponents = DateComponents()
        dateComponents.month = offset
        
        return Calendar.current.date(  byAdding: dateComponents, to: self, wrappingComponents: false)
    }
}

