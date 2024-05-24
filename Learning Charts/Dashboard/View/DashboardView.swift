import SwiftUI
import Charts

enum HealthMetricContext: CaseIterable, Identifiable {
    case steps, weight
    var id: Self { self }
    
    var title: String {
        switch self {
        case .steps: return "Steps"
        case .weight: return "Weight"
        }
    }
}

struct DashboardView: View {
    @AppStorage("hasSeenPermission") var hasSeenPermission = false
    @Environment(HealthKitManager.self) private var healthKitManager
    @State private var isShowingPermissionView = false
    @State private var selectedState: HealthMetricContext = .steps
    
    var isSteps: Bool {
        return selectedState == .steps
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Picker("Selected Step", selection: $selectedState) {
                        ForEach(HealthMetricContext.allCases) {
                            Text($0.title)
                        }
                    }
                    .pickerStyle(.segmented)
                   
                    StepBarChart(selectedState: selectedState, chartData: healthKitManager.stepData)
                    
                    StepPieChart(chartData: ChartMath.averageWeekDayCount(for: healthKitManager.stepData))
                }
            }
            .padding()
            .task {
                await healthKitManager.fetchStatistics(type: .stepCount, options: .cumulativeSum)
                isShowingPermissionView = !hasSeenPermission
            }
            .navigationTitle("Dashboard")
            .navigationDestination(for: HealthMetricContext.self) { metric in
                HealthDataListView(metric: metric)
            }
            .sheet(isPresented: $isShowingPermissionView, onDismiss: {
                // Fetch Health Data
            }, content: {
                HealthKitPermissionView(hasSeen: $hasSeenPermission)
            })
        }
        .tint(isSteps ? .pink : .indigo)
    }
    
   
}

#Preview {
    DashboardView()
        .environment(HealthKitManager())
}
