//
//  ContentView.swift
//  SwiftUI-Mac-11
//
//  Created by Sarah Reichelt on 3/7/20.
//

import SwiftUI

struct ContentView: View {
    @State private var httpSections: [HttpSection] = []

    var body: some View {
        NavigationView {
            List {
                ForEach(httpSections) { section in
                    Section(header: SectionHeaderView(section: section)) {
                        ForEach(section.statuses) { status in
                            NavigationLink(destination: DetailView(httpStatus: status)) {
                                TableRowView(status: status)
                            }
                        }
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .frame(minWidth: 250, idealWidth: 300, maxWidth: 350, maxHeight: .infinity)

            Text("Select an HTTP status")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onAppear {
            self.readCodes()
        }
    }

    func readCodes() {
        httpSections = Bundle.main.decode([HttpSection].self, from: "httpcodes.json")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SectionHeaderView: View {
    let section: HttpSection

    var body: some View {
        HStack(spacing: 20) {
            Text(section.headerCode)
                .layoutPriority(1)

            Text(section.headerText)
                .lineLimit(1)
                .truncationMode(.tail)

            Spacer()
        }
    }
}

struct TableRowView: View {
    let status: HttpStatus

    var body: some View {
        HStack(spacing: 20) {
            Text(status.code)
                .frame(width: 40)
                .font(.headline)
                .foregroundColor(.secondary)

            Text(status.title)
                .truncationMode(.tail)

            Spacer()
        }
    }
}
