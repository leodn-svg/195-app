import Foundation
import MapKit

/// One renderable landmass polygon belonging to a country. A country with
/// several landmasses (islands, exclaves) produces several `CountryShape`s.
struct CountryShape: Identifiable {
    /// Unique per polygon. Not the ISO code — Natural Earth reuses "-99" for
    /// several countries (France, Norway, Kosovo…), so an ISO-based id would
    /// collide and `ForEach` would silently drop the duplicates.
    let id: Int
    /// ISO 3166-1 alpha-3 code where available (may be "-99"), else the name.
    let isoCode: String
    let countryName: String
    let polygon: MKPolygon
}

/// Loads world country borders once from the bundled GeoJSON and exposes them
/// as SwiftUI-renderable polygons.
///
/// Expects a `countries.geojson` resource in the app bundle (Natural Earth
/// 1:110m admin-0 countries). If it's missing the map simply renders the muted
/// base with no overlays, so the app still runs.
enum WorldBorders {
    /// Decoded lazily on first access, then cached for the app's lifetime.
    static let shapes: [CountryShape] = decode()

    private static func decode() -> [CountryShape] {
        guard let url = Bundle.main.url(forResource: "countries", withExtension: "geojson"),
              let data = try? Data(contentsOf: url) else {
            return []
        }
        guard let objects = try? MKGeoJSONDecoder().decode(data) else {
            return []
        }

        var result: [CountryShape] = []
        for case let feature as MKGeoJSONFeature in objects {
            let props = feature.propertiesDictionary
            let name = props["ADMIN"] as? String
                ?? props["NAME"] as? String
                ?? props["name"] as? String
                ?? "Unknown"
            let iso = props["ISO_A3"] as? String
                ?? props["iso_a3"] as? String
                ?? name

            for geometry in feature.geometry {
                switch geometry {
                case let multiPolygon as MKMultiPolygon:
                    for polygon in multiPolygon.polygons {
                        result.append(CountryShape(id: result.count, isoCode: iso, countryName: name, polygon: polygon))
                    }
                case let polygon as MKPolygon:
                    result.append(CountryShape(id: result.count, isoCode: iso, countryName: name, polygon: polygon))
                default:
                    break
                }
            }
        }
        return result
    }
}

private extension MKGeoJSONFeature {
    /// The feature's GeoJSON `properties` object decoded into a dictionary.
    var propertiesDictionary: [String: Any] {
        guard let properties,
              let object = try? JSONSerialization.jsonObject(with: properties) as? [String: Any] else {
            return [:]
        }
        return object
    }
}
