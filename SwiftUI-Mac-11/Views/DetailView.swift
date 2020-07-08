//
//  DetailView.swift
//  SwiftUI-Mac
//
//  Created by Sarah Reichelt on 6/11/19.
//  Copyright © 2019 Sarah Reichelt. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    let sectionTitle: String
    let httpStatus: HttpStatus
    
    @State private var catImage: NSImage?
    @State private var imageIsFlipped = false

    private let flipImageMenuItemSelected = NotificationCenter.default
        .publisher(for: .flipImage)
        .receive(on: RunLoop.main)

    private let saveImageUrlSelected = NotificationCenter.default
        .publisher(for: .saveImage)
    
    var body: some View {
        VStack {
            Text("HTTP Status Code: \(httpStatus.code)")
                .font(.headline)
                .padding()
            Text(httpStatus.title)
                .font(.title)
            
            if let catImage = catImage{
                CatImageView(catImage: catImage, imageIsFlipped: imageIsFlipped)
            } else {
                Spacer()
                ProgressView()
            }
            Spacer()
            DialogsView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            getCatImage()
        }
        .navigationTitle("\(sectionTitle) - \(httpStatus.title)")
        .onReceive(flipImageMenuItemSelected) { _ in
            imageIsFlipped.toggle()
        }
        .onReceive(saveImageUrlSelected) { publisher in
            if let saveUrl = publisher.object as? URL,
               let imageData = catImage?.tiffRepresentation {
                if let imageRep = NSBitmapImageRep(data: imageData) {
                    if let saveData = imageRep.representation(using: .jpeg, properties: [:]) {
                        try? saveData.write(to: saveUrl)
                    }
                }
            }
        }
    }
    
    func getCatImage() {
        let url = httpStatus.imageUrl
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
            } else if let data = data {
                DispatchQueue.main.async {
                    catImage = NSImage(data: data)
                }
            }
        }
        task.resume()
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(sectionTitle: "4xx", httpStatus: HttpStatus(code: "404", title: "Not Found"))
    }
}

struct CatImageView: View {
    @AppStorage("showCopyright") var showCopyright: Bool = false

    let catImage: NSImage
    let imageIsFlipped: Bool
    
    var body: some View {
        Image(nsImage: catImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .rotation3DEffect(Angle(degrees: imageIsFlipped ? 180 : 0),
                              axis: (x: 0, y: 1, z: 0))
            .animation(.default)
            .overlay(
                Text(showCopyright ? "Copyright © https://http.cat" : "")
                    .padding(6)
                    .font(.caption)
                    .foregroundColor(.white)
                    .shadow(radius: 5)
                ,alignment: .bottomTrailing)
    }
}
