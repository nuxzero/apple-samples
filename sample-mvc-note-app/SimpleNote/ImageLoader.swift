//
//  ImageLoader.swift
//  SimpleNoteMVC
//
//  Created by Natthawut Haematulin on 16/1/2564 BE.
//

import UIKit
import Foundation

class ImageLoader {
    static func loadImage(with imageView: UIImageView, for urlString: String, completionHandler: ( (Result<URL, Error>) -> Void)?) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                completionHandler?(.failure(error!))
                return
            }
            
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data)
                completionHandler?(.success(urlResponse!.url!))
            }
        }.resume()
    }
}
