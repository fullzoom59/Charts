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
                    
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                Label("Averages", systemImage: "calendar")
                                    .font(.title3.bold())
                                    .foregroundStyle(.red)
                                Text("Last 28 Days")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                                
                            Spacer()
                                
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.secondary)
                        }
                        .padding(.bottom, 12)
                       
                        RoundedRectangle(cornerRadius: 12)
                            .frame(height: 240)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.secondarySystemBackground))
                    )
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
