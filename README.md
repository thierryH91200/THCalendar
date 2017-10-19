# THCalendar

# THCalendarView [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
CalendarView framework written in Swift for OS X

# Usage

## Initialize the Calendar View

```
let calendarView = THCalendarView()
```

## Overriding Preferences

```
var preferences = THCalendarView.Preferences()
preferences.calendar.backgroundColor = NSColor.gray
preferences.calendar.textColor = NSColor.white

preferences.date.circleBackgroundColor = NSColor.yellow
preferences.date.dotColor = NSColor.green

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
calendarView.selectedDate = NSDate()
```
