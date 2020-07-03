//
//  Settings.swift
//  SwiftUI-Mac-11
//
//  Created by Sarah Reichelt on 3/7/20.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("showCopyright") var showCopyright: Bool = false

    var body: some View {
        Toggle(isOn: $showCopyright) {
            Text("Show Copyright Notice")
        }
        .frame(width: 220, height: 80)
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
