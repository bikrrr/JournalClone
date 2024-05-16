//
//  ContentView.swift
//  JournalClone
//
//  Created by Uhl Albert on 5/16/24.
//

import SwiftUI

struct ContentView: View {
    @State private var toolbarOpacity: Double = 0

    let fadeInThreshold: CGFloat = 70
    static let appBackgroundColor = Color(red: 248/255, green: 244/255, blue: 244/255)

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    HStack {
                        Text("Journal")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                        settingsButton
                            .background(GeometryReader { geo in
                                Color.clear
                                    .preference(key: ViewOffsetKey.self, value: geo.frame(in: .global).minY)
                            })
                    }
                    .padding(.vertical)

                    ForEach(1 ..< 42) { index in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(UIColor.systemBackground))
                            .frame(height: 88)
                            .overlay(
                                HStack {
                                    Text("Item \(index)")
                                    Spacer()
                                }
                                .padding(.horizontal, 16)
                            )
                            .padding(.horizontal, 0)
                            .padding(.vertical, 10)
                            .shadow(color: Color.black.opacity(0.1), radius: 12)
                    }
                }
                .padding(.horizontal)
            }
            .onPreferenceChange(ViewOffsetKey.self) { value in
                withAnimation(.easeInOut(duration: 0.1)) {
                    toolbarOpacity = value < fadeInThreshold ? 1 : 0
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Journal")
                        .bold()
                        .opacity(toolbarOpacity)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    settingsButton
                        .opacity(toolbarOpacity)
                }
            }
            .navigationBarBackButtonHidden()
            .background(Self.appBackgroundColor.edgesIgnoringSafeArea(.all))
        }
    }

    private var settingsButton: some View {
        Button(action: { print("Button tapped") }) {
            Image(systemName: "line.3.horizontal.decrease")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 18, height: 18)
                .foregroundColor(Color(UIColor.label))
                .padding(7)
                .background(Circle().fill(Color(UIColor.secondarySystemFill)))
        }
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
