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
    
    @IBAction func toggle(_ sender: UIButton) {
        navigationController?.setNavigationBarHidden(navigationController?.isNavigationBarHidden == false, animated: true)
               }

               override var prefersStatusBarHidden: Bool {
                   return navigationController?.isNavigationBarHidden == true
               }

               override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
                   return UIStatusBarAnimation.slide
    }
   
        
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
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
