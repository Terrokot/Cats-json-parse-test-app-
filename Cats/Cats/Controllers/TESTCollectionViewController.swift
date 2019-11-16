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
           
           let jsonUrlString = "https://api.myjson.com/bins/6cc0e"
           
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
    
    
       
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }
    
    //MARK: Navigation
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UICollectionViewCell,
        let indexPath = self.collectionView.indexPath(for: cell) {
                let cat = cats[indexPath.row]
                let imageVC = segue.destination as! ImageViewController
                if let url = cat.imageUrl {
                    imageVC.viewImageUrl = url
                }
            }
    }
    
    
}

// MARK: UICollectionViewDelegateFlowLayout

extension TESTCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/3.0
        let yourHeight = yourWidth

        return CGSize(width: yourWidth, height: yourHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
