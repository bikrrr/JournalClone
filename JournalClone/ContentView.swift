//
//  ContentView.swift
//  JournalClone
//
//  Created by Uhl Albert on 5/16/24.
//

import SwiftUI

struct ContentView: View {
    @State private var bottomOfRect: CGFloat = 0
    let offset: CGFloat = 98

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 0) {
                        HStack {
                            Text("Journal")
                                .font(.largeTitle)
                                .bold()
                            Spacer()
                            settingsButton
                        }
                        .onChange(of: geometry.frame(in: .global).minY) { _, newValue in
                            bottomOfRect = newValue
                        }

                        ForEach(1..<42) { index in
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
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Journal")
                            .bold()
                            .opacity(computeOpacity())
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        settingsButton
                            .opacity(computeOpacity())
                    }
                }
                .navigationBarBackButtonHidden()
                .background(Color(red: 248/255, green: 244/255, blue: 244/255))
            }
        }
    }

    private func computeOpacity() -> Double {
        let transitionRange: CGFloat = 40 // The range over which the opacity changes
        let transitionStart = offset - 20 // Start fading when bottomOfRect reaches this value
        let transitionEnd = offset + transitionRange // End fading when bottomOfRect reaches this value

        // Calculate opacity based on current scroll position
        if bottomOfRect <= transitionStart {
            return 1.0
        } else if bottomOfRect >= transitionEnd {
            return 0.0
        } else {
            // Linear interpolation between 1 and 0
            return Double(1 - (bottomOfRect - transitionStart) / transitionRange)
        }
    }

    private var settingsButton: some View {
        Button(action: {print("Button tapped") } ) {
            Image(systemName: "line.3.horizontal.decrease")
                .resizable() // Makes the image resizable
                .aspectRatio(contentMode: .fit) // Maintains the aspect ratio
                .frame(width: 18, height: 18) // Sets the precise size of the image
                .bold()
                .foregroundColor(Color(UIColor.label))
                .padding([.horizontal, .vertical], 7)
                .background(Circle().fill(Color(UIColor.secondarySystemFill)))
        }
    }
}

#Preview {
    ContentView()
}
