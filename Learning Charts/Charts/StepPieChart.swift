import SwiftUI
import Charts

struct StepPieChart: View {
    var chartData: [WeekdayChartData] = []
    
    var body: some View {
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
            
            Chart {
                ForEach(chartData) { weekDay in
                    SectorMark(
                        angle: .value("Average Steps", weekDay.value),
                        innerRadius: .ratio(0.618),
                        angularInset: 1
                    )
                    .foregroundStyle(.pink.gradient)
                    .cornerRadius(6)
                    
                }
            }
            .frame(height: 240)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

#Preview {
    StepPieChart(chartData: ChartMath.averageWeekDayCount(for: HealthMetric.mockData))
}
