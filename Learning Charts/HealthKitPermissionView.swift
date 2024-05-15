import SwiftUI

struct HealthKitPermissionView: View {
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
                
            }
            .buttonStyle(.borderedProminent)
            .tint(.pink)
        }
        .padding()
    }
}

#Preview {
    HealthKitPermissionView()
}
