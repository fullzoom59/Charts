import Foundation

extension Date {
    var weekdayInt: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
    var weekdayTitle: String {
        self.formatted(.dateTime.weekday(.wide))
    }
}
