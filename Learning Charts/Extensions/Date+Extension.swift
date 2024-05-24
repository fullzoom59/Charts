import Foundation

extension Date {
    var weekDayInt: Int {
        return Calendar.current.component(.weekday, from: self)
    }
}
