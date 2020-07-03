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
                    Text("Dark mode").fontWeight(.medium)
                }.padding(.bottom, 2).padding(.top, 1)

                Button(action: {
                    NSApp.appearance = NSAppearance(named: .aqua)
                    appTheme = "light"
                }) {
                    Text("Light mode").fontWeight(.medium)
                }.padding(.bottom, 2).padding(.top, 1)

                Button(action: {
                    NSApp.appearance = nil
                    appTheme = "system"
                }) {
                    Text("System mode").fontWeight(.medium)
                }.padding(.bottom, 2).padding(.top, 1)
            }

        }

//        Settings {
//            SettingsView()
//        }
    }
}
