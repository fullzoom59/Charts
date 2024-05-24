import Foundation

struct HealthMetric: Identifiable {
    let id = UUID()
    let date: Date
    let value: Double
    
    #if DEBUG
    static var mockData: [HealthMetric] {
        var array = [HealthMetric]()
        
        for index in 0..<28 {
            array.append(
                HealthMetric(
                    date: Calendar.current.date(byAdding: .day, value: -index, to: .now)!,
                    value: .random(in: 4_000...15_000)
                )
            )
        }
        return array
    }
    #endif
}
