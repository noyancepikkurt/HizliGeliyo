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
    private var ItemListViewModel : ItemsListViewModel?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchedItems = [ItemsModel]() {
        didSet {
            nameLabel.text = ""
            self.collectionView.reloadData()
        }
    }
    
    var selectedCell = ""
    var isSearching = false
    var buttonBasildiMi = false
    
    private var items = [ItemsModel]()
    
    var itemsModel = [ItemsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let design : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let width = self.collectionView.frame.size.width
        
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        design.minimumInteritemSpacing = 20
        design.minimumLineSpacing = 10
        
        let cellWidth = (width-60) / 2
        design.itemSize = CGSize(width: cellWidth, height: cellWidth*1.85)
        
        collectionView!.collectionViewLayout = design
        
        // shadowBox +++
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.searchBar.delegate = self
            
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        

        getData()
    }
    
    @IBAction func sortButtonClicked(_ sender: Any) {
        
        buttonBasildiMi = true
        collectionView.reloadData()
        
    }
    
    
   @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func getData() {
        let url = URL(string: "https://fakestoreapi.com/products")!
        
        WebService().downloadInfos(url: url) { (items) in
            DispatchQueue.main.async {
                if let items = items {
                    self.items = items
                    self.searchedItems = items
                }
            }
        }
    }
    
    @IBAction func filtreButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toFilterVC", sender: nil)
    }
}


extension ProductListVC:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                
        if isSearching {
            return self.searchedItems.count
        } else {
            switch selectedCell {
            case "men's clothing":
                let filter = items.filter { $0.category.starts(with: "m") }
                nameLabel.text = "Men's Clothing Category : "
                return filter.count
            case "jewelery":
                let filter = items.filter { $0.category.starts(with: "j") }
                nameLabel.text = "Jewelery Category : "
                return filter.count
                
            case "electronics" :
                let filter = items.filter { $0.category.starts(with: "e") }
                nameLabel.text = "Electronics Category : "
                return filter.count
                
            case "women's clothing":
                let filter = items.filter { $0.category.starts(with: "w") }
                nameLabel.text = "Women's Clothing Category: "
                return filter.count
                
            default:
                return self.searchedItems.count
            }
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        
        let data = self.searchedItems[indexPath.item]
        let sorting = items.sorted()
        // cell.load(with: data)
        
        if buttonBasildiMi {
            cell.load(with: sorting[indexPath.row])
        } else {
            cell.load(with: data)
        }
        
        if isSearching {
            cell.load(with: data)
            
        } else {
            switch selectedCell {
            case "men's clothing":
                let filter = items.filter { $0.category.starts(with: "m")}.sorted()
                cell.load(with: filter[indexPath.row])
            case "jewelery":
                let filter = items.filter { $0.category.starts(with: "j")}.sorted()
                cell.load(with: filter[indexPath.row])
            case "electronics" :
                let filter = items.filter { $0.category.starts(with: "e")}.sorted()
                cell.load(with: filter[indexPath.row])
            case "women's clothing":
                let filter = items.filter { $0.category.starts(with: "w")}.sorted()
                cell.load(with: filter[indexPath.row])
            default:
                print("default")
            }
        }
        return cell
    }
}

extension ProductListVC:UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = true
        self.filterArray(searchText: searchText)
    }
    func filterArray(searchText:String) {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines) != "" && isSearching == true {
            searchedItems = items.filter { $0.title.starts(with: searchText)}
        } else {
            searchedItems = items
        }
    }
    
}



