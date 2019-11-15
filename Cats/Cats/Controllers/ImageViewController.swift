//
//  ImageViewController.swift
//  Cats
//
//  Created by Egor Tereshonok on 11/12/19.
//  Copyright © 2019 Egor Tereshonok. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    
    @IBOutlet var imageView: UIImageView!
    
    var viewImageUrl = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(viewImageUrl)
        fetchImage()
       /*
        DispatchQueue.global().async {
            guard let imageUrl = URL(string: self.viewImageUrl) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: imageData)
            }
        }
 */


    }
    
    func fetchImage() {
        
        guard let url = URL(string: viewImageUrl) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        } .resume()
    }
}
