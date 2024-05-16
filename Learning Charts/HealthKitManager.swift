import HealthKit
import Observation

@Observable
class HealthKitManager {
    let store = HKHealthStore()
    let types: Set = [HKQuantityType(.stepCount), HKQuantityType(.bodyMass)]
    
    func addSimulatorData() async {
        var mockSamples: [HKQuantitySample] = []
        
        for item in 0 ..< 28 {
            let stepQuantity = HKQuantity(unit: .count(), doubleValue: .random(in: 4_000...20_000))
            let weightQuantity = HKQuantity(unit: .pound(), doubleValue: .random(in: 160 + Double(item / 3)...165 + Double(item / 3)))
            
            guard let startDate = Calendar.current.date(byAdding: .day, value: -item, to: .now),
                  let endDate = Calendar.current.date(byAdding: .second, value: 1, to: startDate)
            else {
                return
            }
            
            let stepSample = HKQuantitySample(type: HKQuantityType(.stepCount), quantity: stepQuantity, start: startDate, end: endDate)
            let weightSample = HKQuantitySample(type: HKQuantityType(.bodyMass), quantity: weightQuantity, start: startDate, end: endDate)
            
            mockSamples.append(stepSample)
            mockSamples.append(weightSample)
        }
        
        do {
            try await store.save(mockSamples)
            print("Dummy data sent up ✅")
        } catch {
            print(error.localizedDescription)
        }
    }
}
