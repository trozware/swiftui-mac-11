//
//  ContentView.swift
//  SwiftUI-Mac-11
//
//  Created by Sarah Reichelt on 3/7/20.
//

import SwiftUI

struct ContentView: View {
    @State private var httpSections: [HttpSection] = []
    @State private var selection: Int? = nil
    @AppStorage("appTheme") var appTheme: String = "system"

    var body: some View {
        NavigationView {
            List {
                ForEach(httpSections) { section in
                    NavigationLink(destination: StatusList(title: section.headerText,
                                                           statuses: section.statuses)) {
                        ListRowView(code: section.headerCode, title: section.headerText)
                    }
                }
            }
            .listStyle(InsetListStyle())
            .frame(minWidth: 150, idealWidth: 150, maxWidth: 250, maxHeight: .infinity)


            Text("Select a category.")
                .frame(maxWidth: .infinity, maxHeight: .infinity)

        }
        .onAppear {
            readCodes()
            checkTheme()
        }
        .navigationTitle("HTTP Status Codes")
    }

    func readCodes() {
        httpSections = Bundle.main.decode([HttpSection].self, from: "httpcodes.json")
    }

    func checkTheme() {
        switch appTheme {
            case "dark":
                NSApp.appearance = NSAppearance(named: .darkAqua)
            case "light":
                NSApp.appearance = NSAppearance(named: .aqua)
            default:
                NSApp.appearance = nil
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct StatusList: View {
    var title: String
    var statuses: [HttpStatus]

    var body: some View {
        NavigationView {
            List {
                ForEach(statuses) { status in
                    NavigationLink(destination: DetailView(httpStatus: status)) {
                        ListRowView(code: status.code, title: status.title)
                    }
                }
            }
            .listStyle(InsetListStyle())
            .frame(minWidth: 200, idealWidth: 200, maxWidth: 350, maxHeight: .infinity)

            Text("Select an HTTP status.")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationTitle(title)
    }
}

struct ListRowView: View {
    let code: String
    let title: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(code)
                .font(.largeTitle)
                .foregroundColor(.primary)
                
            Text(title)
                .font(.title2)
                .truncationMode(.tail)
        }
        .padding(.vertical)
    }
}
