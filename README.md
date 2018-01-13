[![BCH compliance](https://bettercodehub.com/edge/badge/thierryH91200/THCalendar?branch=master)](https://bettercodehub.com/)



# THCalendar


CalendarView framework written in Swift for OS X

![Alt text](https://github.com/thierryH91200/THCalendar/blob/master/THCalendar.jpg)


# Usage

## Initialize the Calendar View

```
let calendarView = THCalendarView()
```

## Overriding Preferences

```
var preferences = THCalendarView.globalPreferences

preferences.calendar.textColor = NSColor.darkGray
preferences.calendar.cellColorDefault = NSColor(white: 0.0, alpha: 0.1)
preferences.calendar.cellColorToday = NSColor.darkGray
preferences.calendar.borderColor = NSColor.red
preferences.calendar.backgroundColors = NSColor.darkGray
preferences.calendar.beginWeek = .monday

preferences.date.circleBackgroundColor = NSColor.yellow
preferences.date.dotColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)

THCalendarView.globalPreferences = preferences
```

## Add Calendar to the view hierarchy

```
addChildViewController(calendarView)
calendarView.view.frame = containerView.frame
view.addSubview(calendarView.view)
```

## Set the calendar properties

```
calendarView.counts = generateCounts()
calendarView.selectedDate = Date()
```
