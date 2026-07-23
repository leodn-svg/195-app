import SwiftUI
import MapKit

/// The home tab: a full-bleed map with an info card tray anchored to the
/// bottom. The glass tab bar floats over the card's lower edge (see RootView).
struct HomeView: View {
    /// Centered on Europe to echo the Figma frame (Berlin pin visible).
    @State private var camera = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51.5, longitude: 10.0),
            span: MKCoordinateSpan(latitudeDelta: 32, longitudeDelta: 32)
        )
    )

    private let berlin = CLLocationCoordinate2D(latitude: 52.52, longitude: 13.405)

    var body: some View {
        ZStack(alignment: .bottom) {
            Map(position: $camera) {
                // Every country drawn as a grey polygon on top of the muted
                // base map. Marking a country visited later just recolors its
                // fill — see WorldBorders / DesignSystem.
                ForEach(WorldBorders.shapes) { shape in
                    MapPolygon(shape.polygon)
                        .foregroundStyle(DesignSystem.unvisitedCountryFill)
                        .stroke(DesignSystem.countryStroke, style: StrokeStyle(lineWidth: 0.5, lineJoin: .round))
                }

                Annotation("Berlin", coordinate: berlin) {
                    LocationDot()
                }
                .annotationTitles(.hidden)
            }
            .mapStyle(.standard(elevation: .flat, emphasis: .muted, pointsOfInterest: .excludingAll, showsTraffic: false))

            InfoCard()
        }
        // The whole stack ignores the safe area, so both the map and the card
        // reach the physical bottom — the card slides *under* the floating
        // glass tab bar, which then reads as sitting on top of it.
        .ignoresSafeArea()
    }
}

/// A location marker styled like the blue dot in the design.
private struct LocationDot: View {
    var body: some View {
        Circle()
            .fill(.tint)
            .frame(width: 18, height: 18)
            .overlay(Circle().stroke(.white, lineWidth: 3))
            .shadow(color: .black.opacity(0.25), radius: 3, y: 1)
    }
}

#Preview {
    HomeView()
}
