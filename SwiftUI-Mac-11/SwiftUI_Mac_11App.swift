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
            CommandMenu("Theme") {
                Button(action: {
                    NSApp.appearance = NSAppearance(named: .darkAqua)
                    appTheme = "dark"
                }) {
                    Label("Dark", systemImage: "moon.stars")
                }

                Button(action: {
                    NSApp.appearance = NSAppearance(named: .aqua)
                    appTheme = "light"
                }) {
                    Label("Light", systemImage: "sun.max")
                }

                Button(action: {
                    NSApp.appearance = nil
                    appTheme = "system"
                }) {
                    Label("System", systemImage: "desktopcomputer")
                }
            }
        }

//        Settings {
//            SettingsView()
//        }
    }
}
