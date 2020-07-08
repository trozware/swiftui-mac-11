//
//  ContentView.swift
//  SwiftUI-Mac-11
//
//  Created by Sarah Reichelt on 3/7/20.
//

import SwiftUI

struct ContentView: View {
    @State private var httpSections: [HttpSection] = []
    @State private var showSamplesSheet = false

    @AppStorage("appTheme") var appTheme: String = "system"

    private let openSamplesMenuItemSelected = NotificationCenter.default
        .publisher(for: .showSamples)
        .receive(on: RunLoop.main)

    var body: some View {
        NavigationView {
            List() {
                ForEach(httpSections) { section in
                    NavigationLink(destination: StatusList(title: section.headerText,
                                                           statuses: section.statuses)) {
                        ListRowView(code: section.headerCode, title: section.headerText)
                    }
                }
            }
            .listStyle(InsetListStyle())
            .frame(minWidth: 150, idealWidth: 150, maxWidth: 250,
                   minHeight: 400, maxHeight: .infinity)

            StatusList(title: "", statuses: [])
        }
        .sheet(isPresented: $showSamplesSheet) {
            SamplesView(isVisible: $showSamplesSheet)
        }
        .onAppear {
            readCodes()
            checkTheme()
        }
        .onReceive(openSamplesMenuItemSelected) { _ in
            showSamplesSheet.toggle()
        }
        .navigationTitle("HTTP Status Codes")
        .modifier(ToolbarModifier())
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
                    NavigationLink(destination: DetailView(sectionTitle: title, httpStatus: status)) {
                        ListRowView(code: status.code, title: status.title)
                    }
                }
            }
            .listStyle(InsetListStyle())
            .frame(minWidth: 200, idealWidth: 200, maxWidth: 350, maxHeight: .infinity)

            Text(statuses.isEmpty ? "Select a category." : "Select an HTTP status.")
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

struct ToolbarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        NotificationCenter.default.post(name: .flipImage, object: nil)
                    } ) {
                        Image(systemName: "arrow.left.and.right.righttriangle.left.righttriangle.right")
                    }
                }

                ToolbarItem {
                    Button(action: {
                        NotificationCenter.default.post(name: .showSamples, object: nil)
                    } ) {
                        Image(systemName: "uiwindow.split.2x1")
                    }
                }
            }
    }
}
