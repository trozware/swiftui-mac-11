//
//  FormSamplesView.swift
//  SwiftUI-Mac
//
//  Created by Sarah Reichelt on 10/11/19.
//  Copyright © 2019 Sarah Reichelt. All rights reserved.
//

import SwiftUI

struct FormSamplesView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var selectedDate = Date()
    @State private var selectedTime = Date()
    @State private var selectedColor = Color.blue

    // TODO: Focus in text field
    
    var body: some View {
        VStack(spacing: 30) {
            TextField("Enter your email address", text: $email)
            
            SecureField("Enter your password", text: $password)
            
            DatePicker(selection: $selectedDate, displayedComponents: [ .date ]) {
                Text("Pick a date:")
            }

            DatePicker(selection: $selectedTime, displayedComponents: [ .hourAndMinute ]) {
                Text("Pick a time:")
            }

            ColorPicker(selection: $selectedColor, supportsOpacity: true) {
                Text("Choose a color:").padding()
            }
            .frame(height: 50)
            .background(selectedColor)
        }
        .padding()
    }
}

struct FormSamplesView_Previews: PreviewProvider {
    static var previews: some View {
        FormSamplesView()
    }
}
