//
//  TESTCollectionViewController.swift
//  Cats
//
//  Created by Egor Tereshonok on 11/13/19.
//  Copyright © 2019 Egor Tereshonok. All rights reserved.
//

import UIKit

private let reuseIdentifier = "TestCell"

class TESTCollectionViewController: UICollectionViewController {
    
    @IBOutlet var testCollectionView: UICollectionView!
    private var cats = [Cats]()
    private var catName: String?
    private var catImageURLT: String?
    
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
                    self.testCollectionView.reloadData()
                   }
               } catch let error {
                   print("Error serialization json", error)
               }
               
           }.resume()
       }
       
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
 
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return cats.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        
        let cat = cats[indexPath.row]
               
               DispatchQueue.global().async {
                   guard let imageUrl = URL(string: cat.imageUrl!) else { return }
                   guard let imageData = try? Data(contentsOf: imageUrl) else { return }
                   
                   DispatchQueue.main.async {
                    cell.testImage.image = UIImage(data: imageData)
                   }
               }
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
