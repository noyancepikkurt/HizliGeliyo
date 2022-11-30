//
//  ProductListVC.swift
//  Hizligeliyo
//
//  Created by Noyan Çepikkurt on 28.11.2022.
//

import UIKit
import SDWebImage


class ProductListVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var ItemListViewModel : ItemsListViewModel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var aramasonucuItemler = [ItemsModel]()
    var aramayapiliyorMu = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tasarim : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let genislik = self.collectionView.frame.size.width
        
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        tasarim.minimumInteritemSpacing = 20
        tasarim.minimumLineSpacing = 10
        
        let hucregenislik = (genislik-60) / 2
        tasarim.itemSize = CGSize(width: hucregenislik, height: hucregenislik*1.85)
        
        collectionView!.collectionViewLayout = tasarim
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.searchBar.delegate = self
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        getData()
        
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func getData() {
        let url = URL(string: "https://fakestoreapi.com/products")!
        
        WebService().downloadInfos(url: url) { (Items) in
            if let Items = Items {
     
                self.ItemListViewModel = ItemsListViewModel(ItemsList: Items)
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
}


extension ProductListVC:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if aramayapiliyorMu == true {
            return aramasonucuItemler.count
        } else {
            return self.ItemListViewModel == nil ? 0 : self.ItemListViewModel.numberOfItemsInSection()
        }
        return self.ItemListViewModel == nil ? 0 : self.ItemListViewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
       
        let ItemsViewModel = self.ItemListViewModel.ItemsAtIndex(indexPath.item)
        
        
        if aramayapiliyorMu == true {
            cell.itemTitleLabel.text = aramasonucuItemler[indexPath.item].title
            cell.itemPriceLabel.text = String("\(aramasonucuItemler[indexPath.item].price) TL ")
            cell.imageView.sd_setImage(with: URL(string: aramasonucuItemler[indexPath.item].image))
            collectionView.reloadData()
            
        } else {
                
                cell.itemTitleLabel.text = ItemsViewModel.title
                cell.itemPriceLabel.text = String("\(ItemsViewModel.price) TL")
                cell.imageView.sd_setImage(with: URL(string: ItemsViewModel.image))
            
        }
        
        return cell
    }
    
    
    
}

extension ProductListVC:UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        aramayapiliyorMu = true
        aramasonucuItemler = ItemListViewModel.ItemsList.filter { $0.title.starts(with: searchText)}
        
        collectionView.reloadData()
        
    }
}



