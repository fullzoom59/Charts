import Foundation
import Algorithms

struct ChartMath {
    static func averageWeekDayCount(for metric: [HealthMetric]) -> [WeekdayChartData] {
        let sortedByWeekday = metric.sorted { $0.date.weekDayInt < $1.date.weekDayInt }
        
        let weekdayArray = sortedByWeekday.chunked { $0.date.weekDayInt == $1.date.weekDayInt }
        var weekdayChartDate: [WeekdayChartData] = []
        
        for array in weekdayArray {
            guard let firstValue = array.first else { continue }
            let total = array.reduce(0) {$0 + $1.value}
            let avgSteps = total / Double(array.count)
            
            weekdayChartDate.append(.init(date: firstValue.date, value: avgSteps))
        }
        
        return weekdayChartDate
    }
}
