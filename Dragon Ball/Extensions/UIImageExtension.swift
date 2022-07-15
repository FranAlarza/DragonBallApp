//
//  UIImageExtension.swift
//  Dragon Ball
//
//  Created by Fran Alarza on 15/7/22.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadImage(from url: String) {
        guard let imageUrl = URL(string: url) else { return }
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            guard let data = data,
            error == nil,
                  let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200
            else {
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.image = image
            }
            
        }.resume()
    }
}
