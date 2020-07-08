//
//  SwiftUI_Mac_11App.swift
//  SwiftUI-Mac-11
//
//  Created by Sarah Reichelt on 3/7/20.
//

import SwiftUI

@main
struct SwiftUI_Mac_11App: App {
    @AppStorage("appTheme") var appTheme: String = "system"

    @SceneBuilder var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .commands {
            CommandGroup(after: .windowArrangement) {
                Button(action: {
                    NSApp.appearance = NSAppearance(named: .darkAqua)
                    appTheme = "dark"
                }) {
                    Text("Dark mode").fontWeight(.medium)
                }.modifier(MenuButtonStyling())

                Button(action: {
                    NSApp.appearance = NSAppearance(named: .aqua)
                    appTheme = "light"
                }) {
                    Text("Light mode").fontWeight(.medium)
                }.modifier(MenuButtonStyling())

                Button(action: {
                    NSApp.appearance = nil
                    appTheme = "system"
                }) {
                    Text("System mode").fontWeight(.medium)
                }.modifier(MenuButtonStyling())
            }

            CommandMenu("Utilities") {
                Button(action: {
                    NotificationCenter.default.post(name: .flipImage, object: nil)
                }) {
                    Text("Flip Image").fontWeight(.medium)
                }.modifier(MenuButtonStyling())
                .keyboardShortcut("i")

                Button(action: {
                    NotificationCenter.default.post(name: .showSamples, object: nil)
                }) {
                    Text("Toggle UI Samples Window").fontWeight(.medium)
                }.modifier(MenuButtonStyling())
                .keyboardShortcut("u")
            }
        }

        Settings {
            SettingsView()
        }
    }

}

extension Notification.Name {
    static let flipImage = Notification.Name("flip_image")
    static let saveImage = Notification.Name("save_image")
    static let showSamples = Notification.Name("show_samples")
}

struct MenuButtonStyling: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.primary)
            .padding(.bottom, 2)
            .padding(.top, 1)
    }
}

