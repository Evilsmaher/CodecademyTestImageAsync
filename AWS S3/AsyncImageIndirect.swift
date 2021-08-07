//
//  AsyncImageView.swift
//  AWS S3
//
//  Created by Bradley French on 8/5/21.
//

import SwiftUI

struct AsyncImageIndirect: View {
    @StateObject private var loader: ImageLoaderIndirect
    
    init(url: URL) {
        print("Init")
        _loader = StateObject(wrappedValue: ImageLoaderIndirect(url: url))
    }
    
    var body: some View {
        content.onAppear(perform: loader.load)
    }
    
    private var content: some View {
        Group {
            if loader.image != nil {
                Image(uiImage: loader.image!)
                    .resizable()
            }
            else {
                Text("Loading")
            }
        }
    }
}
