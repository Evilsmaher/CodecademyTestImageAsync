//
//  ImageLoader.swift
//  AWS S3
//
//  Created by Bradley French on 8/5/21.
//

import SwiftUI
import Combine
import Foundation

class ImageLoaderIndirect: ObservableObject {
    @Published var image: UIImage?
    private let url: URL
    private var cancellable: AnyCancellable?
    
    init(url: URL) {
        self.url = url
    }
    
    deinit {
        cancel()
    }
    
    /*
     Convert a JSON String to a Dictionary
     */
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error)
            }
        }
        return nil
    }
    
    /*
     Data is guaranteed to be in a base64 encoding
     1. Convert Data to String
     2. Convert String to Dictionary
     3. Collect the "body" from the Dictionary (where the base64 is)
     4. Create a Data instance from the base64 String
     5. Create a UIImage from the base64 String
     */
    func load() {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { String(data: $0.data, encoding: .utf8)! }
            .map { [self] in convertToDictionary(text: $0)! }
            .map { $0["body"]! }
            .map { Data(base64Encoded: $0 as! String)! }
            .map { UIImage(data: $0) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }
    
    func cancel() {
        cancellable?.cancel()
    }
}
