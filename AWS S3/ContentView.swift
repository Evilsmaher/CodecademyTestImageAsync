//
//  ContentView.swift
//  AWS S3
//
//  Created by Bradley French on 8/5/21.
//

import SwiftUI

struct ContentView: View {
    let url = URL(string: "https://codecademytestingbucket.s3.amazonaws.com/download.png")!
    
    let url2 = URL(string: "https://9mnwdcsfrk.execute-api.us-east-1.amazonaws.com")!
    
    var body: some View {
        AsyncImageDirect(url: url)
            .aspectRatio(contentMode: .fit)
        AsyncImageIndirect(url: url2).aspectRatio(contentMode: .fit)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
