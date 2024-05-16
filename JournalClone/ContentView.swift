//
//  ContentView.swift
//  JournalClone
//
//  Created by Uhl Albert on 5/16/24.
//

import SwiftUI

struct ContentView: View {
    @State private var titleOpacity: Double = 0
    @State private var settingsOpacity: Double = 0

    var body: some View {
        GeometryReader { _ in
            NavigationStack {
                ScrollView {
                    VStack(spacing: 0) {
                        HStack {
                            Text("Journal")
                                .font(.largeTitle)
                                .bold()
                                .background(GeometryReader { geo in
                                    Color.clear
                                        .preference(key: ViewOffsetKey.self, value: geo.frame(in: .global).minY)
                                })
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
                        let fadeInStart: CGFloat = 70 // Start fading in earlier

                        if value < fadeInStart {
                            titleOpacity = 1
                            settingsOpacity = 1
                        } else {
                            titleOpacity = 0
                            settingsOpacity = 0
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Journal")
                            .bold()
                            .opacity(titleOpacity)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        settingsButton
                            .opacity(settingsOpacity)
                    }
                }
                .navigationBarBackButtonHidden()
                .background(Color(red: 248/255, green: 244/255, blue: 244/255).edgesIgnoringSafeArea(.all))
            }
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
