//
//  IceCube.swift
//  BlurOverlay
//
//  Created by Dave Kondris on 31/01/21.
//

import SwiftUI

struct IceCube: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var rectPosition = CGPoint(x: 150, y: 150)
    
    @State private var cutout: UIImage?
    let image: UIImage
    let frameSide: CGFloat = 180
    var body: some View {
        
        Image(uiImage: cutout ?? image)
            .frame(width: frameSide, height: frameSide)
            .blur(radius: 5)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 12, style: .continuous).stroke(Color.red, lineWidth: 3))
            .onAppear(perform: {
                processImage()
            })
            .position(rectPosition)
            .gesture(DragGesture().onChanged({ value in
                self.rectPosition = value.location
                processImage()
            }))
        
    }
    
    func processImage() {
        
        //TODO: - Find the image scale size from ContentView and also figure out how much it begins to the left/top of the screen.
        
        cutout = croppedImage(from: image, croppedTo: CGRect(x: rectPosition.x, y: rectPosition.y, width: frameSide, height: frameSide))
    }
}


//MARK: - image processing functions.

func croppedImage(from image: UIImage, croppedTo rect: CGRect) -> UIImage {
    
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    
    let drawRect = CGRect(x: -rect.origin.x, y: -rect.origin.y, width: image.size.width, height: image.size.height)
    
    context?.clip(to: CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height))
    
    image.draw(in: drawRect)
    
    let subImage = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    return subImage!
}


struct IceCube_Previews: PreviewProvider {
    static var previews: some View {
        IceCube(image: UIImage(named: "lyon")!)
    }
}
