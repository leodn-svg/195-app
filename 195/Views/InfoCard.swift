import SwiftUI

/// The floating white card anchored to the bottom of the home screen.
///
/// Matches the Figma "Home" frame: equal 8pt insets on the sides and bottom,
/// 32pt top corners and larger bottom corners that stay concentric with the
/// device's screen. It extends *under* the floating glass tab bar (by ignoring
/// the bottom safe area), so on the surface the tab bar reads as sitting on top
/// of the card. Intentionally empty for now — country info lives here later.
struct InfoCard: View {
    var body: some View {
        DesignSystem.infoCardShape
            .fill(Color(.systemBackground))
            .frame(height: DesignSystem.cardHeight)
            .shadow(color: .black.opacity(0.15), radius: 24, x: 0, y: 8)
            .padding(.horizontal, DesignSystem.cardEdgeInset)
            .padding(.bottom, DesignSystem.cardEdgeInset)
    }
}

#Preview {
    ZStack {
        LinearGradient(colors: [.green, .blue], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
        VStack {
            Spacer()
            InfoCard()
        }
    }
}
