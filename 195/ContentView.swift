import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "globe.europe.africa.fill")
                .font(.system(size: 64))
                .foregroundStyle(.tint)
            Text("195")
                .font(.system(size: 48, weight: .bold, design: .rounded))
            Text("0 of 195 countries visited")
                .font(.headline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ContentView()
}
