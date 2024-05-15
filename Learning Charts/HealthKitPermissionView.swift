import SwiftUI
import HealthKitUI

struct HealthKitPermissionView: View {
    @Environment(HealthKitManager.self) private var healthKitManager
    @Environment(\.dismiss) private var dismiss
    @State private var isShowingHealthKitPermissions = false
    var desctiption = """
    This app displays your step and weight data in interactive charts.

    You can also add new step or weight data to Apple Health from this App. Your data is private and secured.
    """

    var body: some View {
        VStack(spacing: 130) {
            VStack(alignment: .leading) {
                Image(.healthkit)
                    .resizable()
                    .frame(width: 90, height: 90)
                    .shadow(color: .gray.opacity(0.3), radius: 16)
                    .padding(.bottom, 20)
                Text("Apple Health Integration")
                    .font(.title2).bold()
                Text(desctiption)
                    .foregroundStyle(.secondary)
            }
            Button("Connect Apple Health") {
                isShowingHealthKitPermissions = true
            }
            .buttonStyle(.borderedProminent)
            .tint(.pink)
        }
        .padding()
        .healthDataAccessRequest(
            store: healthKitManager.store,
            shareTypes: healthKitManager.types,
            readTypes: healthKitManager.types,
            trigger: isShowingHealthKitPermissions) { result in
                switch result {
                case .success(_):
                    dismiss()
                case .failure(_):
                    dismiss()
                }
            }
    }
}

#Preview {
    HealthKitPermissionView()
        .environment(HealthKitManager())
}
