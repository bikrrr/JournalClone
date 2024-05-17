//
//  ContentView.swift
//  JournalClone
//
//  Created by Uhl Albert on 5/16/24.
//

import SwiftUI

struct ContentView: View {
    @State private var toolbarOpacity: Double = 0

    let fadeThreshold: CGFloat = 70

    static let appBackground = Color(red: 248/255, green: 244/255, blue: 244/255)
    static let cardBackground = Color(UIColor.systemBackground)
    static let cardShadow = Color(red: 25/255, green: 12/255, blue: 12/255)
    static let appName = "Journal Clone"

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    HStack {
                        Text(Self.appName)
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                        settingsButton
                            .background(OffsetObserver())
                    }
                    .padding(.vertical)

                    ForEach(1 ..< 42) { index in
                        CardView(index: index)
                    }
                    .padding(.horizontal, 3)
                }
                .padding(.horizontal)
            }
            .onPreferenceChange(ViewOffsetKey.self) { value in
                withAnimation(.easeInOut(duration: 0.1)) {
                    toolbarOpacity = value < fadeThreshold ? 1 : 0
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text(Self.appName)
                        .bold()
                        .opacity(toolbarOpacity)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    settingsButton
                        .opacity(toolbarOpacity)
                }
            }
            .navigationBarBackButtonHidden()
            .background(Self.appBackground.edgesIgnoringSafeArea(.all))
        }
    }

    private var settingsButton: some View {
        Button(action: { print("Button tapped") }) {
            Image(systemName: "line.3.horizontal.decrease")
                .resizable()
                .bold()
                .aspectRatio(contentMode: .fit)
                .frame(width: 18, height: 18)
                .foregroundColor(Color(UIColor.label))
                .padding(7)
                .background(Circle().fill(Color(UIColor.secondarySystemFill)))
        }
    }
}

struct OffsetObserver: View {
    var body: some View {
        GeometryReader { geo in
            Color.clear
                .preference(key: ViewOffsetKey.self, value: geo.frame(in: .global).minY)
        }
    }
}

struct CardView: View {
    var index: Int

    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Item \(index)")
                    Spacer()
                }
                .padding(.top, 12)
                .padding(.bottom, 8)

                Divider()
                    .padding(.horizontal, -12)
                    .background(.tertiary)

                HStack {
                    Text("Thursday, May 16")
                        .font(.caption)
                        .padding(.vertical, 0)
                    Spacer()
                    Image(systemName: "ellipsis")
                }
                .bold()
                .padding(.top, 2)
                .padding(.bottom, 8)
                .foregroundStyle(.secondary)

            }
            .frame(height: 88)
            .padding(.horizontal, 16)
            .background(ContentView.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: ContentView.cardShadow.opacity(0.15), radius: 12)

        }
        .padding(.vertical, 10)
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    ContentView()
}
