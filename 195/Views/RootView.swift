import SwiftUI

/// App shell: a native `TabView` bottom navigation.
///
/// On iOS 26 the standard tab bar is Liquid Glass and floats over content —
/// here it floats over the home card's lower edge, reading as if it sits on
/// the white card. Search uses `Tab(role: .search)`, which iOS 26 renders as a
/// detached magnifying-glass on the trailing side of the bar (as in the
/// design). Keeping the nav native is what gives the glass, the detached
/// search, and the HIG behavior for free.
struct RootView: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "globe.europe.africa.fill") {
                HomeView()
            }

            Tab("Countries", systemImage: "list.bullet") {
                PlaceholderTab(title: "Countries", systemImage: "list.bullet")
            }

            Tab("Profile", systemImage: "person.fill") {
                PlaceholderTab(title: "Profile", systemImage: "person.crop.circle")
            }

            Tab(role: .search) {
                PlaceholderTab(title: "Search", systemImage: "magnifyingglass")
            }
        }
    }
}

/// Temporary empty state for tabs that aren't built yet.
private struct PlaceholderTab: View {
    let title: String
    let systemImage: String

    var body: some View {
        NavigationStack {
            ContentUnavailableView(title, systemImage: systemImage, description: Text("Coming soon"))
                .navigationTitle(title)
        }
    }
}

#Preview {
    RootView()
}
