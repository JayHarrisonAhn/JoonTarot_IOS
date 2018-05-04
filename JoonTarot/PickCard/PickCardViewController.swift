//
//  PickCardViewController.swift
//  JoonTarot
//
//  Created by Harrison on 2018. 5. 4..
//  Copyright © 2018년 Harrison. All rights reserved.
//

import UIKit

class PickCardViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var cardSet:[UInt32] = []
    
    func isThere(_ num:UInt32) -> Bool {
        if cardSet.count==0 {
            return false
        }
        for i in 1...cardSet.count {
            if (cardSet[i-1]%22) == (num%22) {
                return true
            }
        }
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self

        var currentVar:UInt32 = 0
        
        for _ in 0...2 {
            currentVar = arc4random_uniform(43)
            while(isThere(currentVar)) {
                currentVar = arc4random_uniform(43)
            }
            
            cardSet.append(currentVar)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Card", for: indexPath) as! PickCardCell
        var imageName:String = ""
        
        if cardSet[indexPath.row] < 22 {
            imageName = String(cardSet[indexPath.row])
        } else {
            imageName = "r" + String(cardSet[indexPath.row] % 22)
        }
        print("TarotImage\\" + imageName)
        cell.Image.image = UIImage(named: imageName)
        return cell
    }
}

class PickCardCell: UICollectionViewCell {
    @IBOutlet weak var Image: UIImageView!
}
