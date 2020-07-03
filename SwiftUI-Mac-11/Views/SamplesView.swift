//
//  Samplesview.swift
//  SwiftUI-Mac-11
//
//  Created by Sarah Reichelt on 3/7/20.
//

import SwiftUI

struct SamplesView: View {
    @Binding var isVisible: Bool
    @State private var selectedTab = 0

    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                PickerSamplesView().tabItem { Text("Pickers") }.tag(0)
                SwitchSamplesView().tabItem { Text("Switches") }.tag(1)
                FormSamplesView().tabItem { Text("Form") }.tag(2)
            }

            Spacer()

            Button(action: {
                isVisible = false
            }) {
                Text("Close")
            }
            .keyboardShortcut(.defaultAction)
            .padding(.top, 10)
        }
        .padding()
        .frame(minWidth: 400, idealWidth: 400, maxWidth: .infinity, minHeight: 420, idealHeight: 420, maxHeight: .infinity)
    }
}

struct Samplesview_Previews: PreviewProvider {
    static var previews: some View {
        SamplesView(isVisible: .constant(true))
    }
}

struct ExplanatoryText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.caption)
            .foregroundColor(.secondary)
    }
}
