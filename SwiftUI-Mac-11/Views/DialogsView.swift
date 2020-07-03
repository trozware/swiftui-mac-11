//
//  DialogsView.swift
//  SwiftUI-Mac
//
//  Created by Sarah Reichelt on 13/11/19.
//  Copyright © 2019 Sarah Reichelt. All rights reserved.
//

import SwiftUI

struct DialogsView: View {
    @State private var alertIsShowing = false
    @State private var dialogResult = "Click the buttons above to test the dialogs."
    
    var body: some View {
        VStack(spacing: 6) {
            HStack {
                Button("Alert") {
                    dialogResult = "Showing Alert"
                    alertIsShowing.toggle()
                }

                Spacer()

                Button("File") {
                    dialogResult = "Select where to save the cat image."
                    saveImage()
                }
            }
            .padding(.horizontal)
            .padding(.top, 6)
            
            Text(dialogResult)
                .font(.caption)
                .frame(height: 20)
        }
        .alert(isPresented: $alertIsShowing) {
            Alert(title: Text("Alert"),
                  message: Text("This is an alert with two buttons!"),
                  primaryButton: .default(Text("OK"), action: {
                    dialogResult = "OK clicked in Alert"
                  }), secondaryButton: .cancel({
                    dialogResult = "Cancel clicked in Alert"
                  }))
        }
    }
    
    func saveImage() {
        let panel = NSSavePanel()
        panel.nameFieldLabel = "Save cat image as:"
        panel.nameFieldStringValue = "cat.jpg"
        panel.canCreateDirectories = true
        panel.begin { response in
            if response == NSApplication.ModalResponse.OK, let fileUrl = panel.url {
                dialogResult = "Saving to \(fileUrl.path)"
                NotificationCenter.default.post(name: .saveImage, object: fileUrl)
            } else {
                dialogResult = "Cancel clicked in Save dialog"
            }
        }
    }
}

struct DialogsView_Previews: PreviewProvider {
    static var previews: some View {
        DialogsView()
    }
}
