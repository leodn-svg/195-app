import SwiftUI

/// Central design tokens so the whole app stays visually consistent.
///
/// Corner radii follow Apple's Human Interface Guidelines: surfaces use the
/// *continuous* corner curve (the "squircle"), and where a surface sits near
/// the edge of the display its corners are kept *concentric* with the screen —
/// the bottom of the info card curves in sympathy with the iPhone's own
/// rounded corners rather than fighting them.
enum DesignSystem {

    // MARK: Info-card geometry (from the Figma "Home" frame)

    /// Top corners of the bottom info card — a comfortable card radius.
    static let cardTopCornerRadius: CGFloat = 32

    /// Bottom corners of the info card. Larger than the top so the card hugs
    /// the device's rounded screen corners concentrically (iPhone 16 Pro's
    /// display radius is ~55pt; the card is inset 8pt from the edge).
    static let cardBottomCornerRadius: CGFloat = 55

    /// Inset of the info card from the screen edges (matches Figma: 8pt).
    static let cardEdgeInset: CGFloat = 8

    /// Height of the info card (matches Figma: 357pt). The glass tab bar
    /// floats over its lower edge; the remaining area holds country info later.
    static let cardHeight: CGFloat = 357

    /// The card's asymmetric, continuous-curve shape.
    static var infoCardShape: UnevenRoundedRectangle {
        UnevenRoundedRectangle(
            topLeadingRadius: cardTopCornerRadius,
            bottomLeadingRadius: cardBottomCornerRadius,
            bottomTrailingRadius: cardBottomCornerRadius,
            topTrailingRadius: cardTopCornerRadius,
            style: .continuous
        )
    }
}
