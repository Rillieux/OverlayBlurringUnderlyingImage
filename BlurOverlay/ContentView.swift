//
//  ContentView.swift
//  BlurOverlay
//
//  Created by Dave Kondris on 31/01/21.
//

import SwiftUI

struct ContentView: View {
    @State private var image: UIImage = UIImage(named: "lyon")!
    var body: some View {
        ZStack{
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
            IceCube(image: image)
        }
        .ignoresSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
