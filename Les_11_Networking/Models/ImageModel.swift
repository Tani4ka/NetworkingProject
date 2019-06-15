//
//  ImageModel.swift
//  Les_11_Networking
//
//  Created by Tetiana Hranchenko on 6/15/19.
//  Copyright © 2019 Canux Corporation. All rights reserved.
//

import UIKit

class ImageModel {
    
    var imagePath: String {
        // didSet будет вызван, когда установится новое значение
        // когда изменится imagePath - обновить image
        didSet {
            self.image = self.imageLoading(path: imagePath)
        }
    }
    
    private(set) var image: UIImage?
    
    func imageLoading(path: String) -> UIImage? {
//        print("Enter to imageLoading")
        if !path.isEmpty,
            let url = URL(string: path),
            let data = try? Data(contentsOf: url),
            let image = UIImage(data: data) {
            
            return image
        }
      
        return nil
    }
    
    init(imagePath: String) {
        self.imagePath = imagePath
        // т.к. didSet и willSet в инициализаторах не вызываются - создаем и вызываем функцию
        self.image = self.imageLoading(path: imagePath)
    }
}
