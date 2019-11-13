//
//  CatsCollection.swift
//  Cats
//
//  Created by Egor Tereshonok on 11/13/19.
//  Copyright © 2019 Egor Tereshonok. All rights reserved.
//

import UIKit

class CatsCollection: UIViewController {

       private var cats = [Cats]()
       private var catName: String?
       private var catImageURLT: String?
       
    @IBOutlet var collectionView: UICollectionView!
    
       override func viewDidLoad() {
           super.viewDidLoad()
           
           fetchData()
           
           
       }
       
       
       func fetchData() {
           
           let jsonUrlString = "https://api.myjson.com/bins/ykvm2"
           
           guard let url = URL(string: jsonUrlString) else { return }
           
           URLSession.shared.dataTask(with: url) { (data, response, error) in
               
               guard let data = data else { return }
               
               do {
                   self.cats = try JSONDecoder().decode([Cats].self, from: data)
                   
                   DispatchQueue.main.async {
                    self.collectionView.reloadData()
                   }
               } catch let error {
                   print("Error serialization json", error)
               }
               
           }.resume()
       }
    
    

}

extension CatsCollection: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cats.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionViewCell
        /*
        let cat = cats[indexPath.row]
        
        DispatchQueue.global().async {
            guard let imageUrl = URL(string: cat.imageUrl!) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            
            DispatchQueue.main.async {
                cell.catImage.image = UIImage(data: imageData)
            }
        }
 */
        
            return cell
    }
    
    
}
