//
//  SecondTabController.swift
//  My First Project
//
//  Created by Yusmi Putra on 7/24/23.
//

import UIKit

class SecondTabController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var listMovie: [[String: Any]] = [
        ["judul" : "The Simpsons", "gambar" : "movie1", "harga" : 45000],
        ["judul" : "Shang-Chi", "gambar" : "movie2", "harga" : 65000],
        ["judul" : "Jungle Cruise", "gambar" : "movie3", "harga" : 35000],
        ["judul" : "Home Alon", "gambar" : "movie4", "harga" : 45000],
        ["judul" : "A Monster Call", "gambar" : "movie5", "harga" : 65000],
        ["judul" : "Venom", "gambar" : "movie7", "harga" : 35000],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = GridFlowLayout()
                layout.itemsPerRow = 3 // Set the desired cross-axis count here
                collectionView.collectionViewLayout = layout
        
        // Do any additional setup after loading the view.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieCell
        let item = listMovie[indexPath.row]
        cell.imageMovie.image = UIImage(named: item["gambar"] as! String)
        //        cell.judulMovie.text = item["judul"] as? String
        //
        return cell
    }

    
}

//extension SecondTabController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: (collectionView.bounds.size.width / 3) - 4, height: (collectionView.bounds.size.width / 3) - 4 )
//    }
//}



class GridFlowLayout: UICollectionViewFlowLayout {
    // Desired number of items per row
    var itemsPerRow: Int = 2

    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }

        // Calculate the total available width for the items
        let availableWidth = collectionView.bounds.width - (sectionInset.left + sectionInset.right)

        // Calculate the space required for the inter-item spacing
        let spacingWidth = minimumInteritemSpacing * CGFloat(itemsPerRow - 1)

        // Calculate the width for each item based on the available space and itemsPerRow
        let itemWidth = (availableWidth - spacingWidth) / CGFloat(itemsPerRow)

        // Set the size of each item in the grid (cell size)
        let itemSize = CGSize(width: itemWidth, height: itemWidth)
        self.itemSize = itemSize

        // Set the spacing between items and lines in the grid
        self.minimumInteritemSpacing = minimumInteritemSpacing
        self.minimumLineSpacing = minimumLineSpacing
    }
}
