//
//  FirstLoginView.swift
//  
//
//  Created by Eli Hersher on 4/17/20.
//

import SwiftUI

struct FirstLoginView: View {
    
    
    
    var titles = ["Welcome to Dr. Horticulture!", "Settings", "Import", "Lighting", "Process", "About"]

    var captions =  [" ", "Set plant type, accuracy, fertilizer recommendations and more.", "Take a photo of your plant or import one from your library.","Ensure that the plant is 24\"/60cm above the canopy with sufficient light.", "Image analysis will determine if your plant has sufficient fertilizer.", "Additional articles on NDVI, fertilizer selections and the Earth and Environment Department at FIU."]
    
    var subviews = [
        UIHostingController(rootView: Image("Logo-1").resizable().frame(maxWidth: 200, maxHeight: 200)),
        UIHostingController(rootView: Image(systemName: "gear").resizable().foregroundColor(greenColor).frame(maxWidth: 100, maxHeight: 100)),
        UIHostingController(rootView: Image(systemName: "plus").resizable().foregroundColor(greenColor).frame(maxWidth: 100, maxHeight: 100)),
        UIHostingController(rootView: Image(systemName: "sun.max").resizable().foregroundColor(greenColor).frame(maxWidth: 100, maxHeight: 100)),
        UIHostingController(rootView: Image(systemName: "arrow.2.circlepath.circle").resizable().foregroundColor(greenColor).frame(maxWidth: 100, maxHeight: 100)),
        UIHostingController(rootView: Image(systemName: "book").resizable().foregroundColor(greenColor).frame(maxWidth: 100, maxHeight: 100)),
    ]
    
    @State var currentPageIndex = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text(titles[currentPageIndex])
                    .font(.title)
                    
                Text(captions[currentPageIndex])
                .font(.subheadline)
                .foregroundColor(.gray)
                .frame(width: 300, height: 50, alignment: .leading)
                .lineLimit(nil)

            }
            .padding()
            HStack {
                PageControl(numberOfPages: subviews.count, currentPageIndex: $currentPageIndex)
                Spacer()
                Button(action: {
                    if self.currentPageIndex+1 == self.subviews.count {
                        self.currentPageIndex = 0
                    } else {
                        self.currentPageIndex += 1
                    } 
                    
                }) {
                    ButtonContent()
                }
            }.padding()
                PageViewController(currentPageIndex: $currentPageIndex, viewControllers: subviews)
                .frame(height: 200)
                .padding()
        }
    }
}

struct ButtonContent: View {
    var body: some View {
        Image(systemName: "arrow.right")
        .resizable()
        .foregroundColor(.white)
        .frame(width: 30, height: 30)
        .padding()
        .background(greenColor)
        .cornerRadius(30)
    }
}

struct Subview: View {
    
    var imageString: String
    
    var body: some View {
        Image(imageString)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .clipped()
    }
}

struct FirstLoginView_Previews: PreviewProvider {
    static var previews: some View {
        FirstLoginView()
    }
}
