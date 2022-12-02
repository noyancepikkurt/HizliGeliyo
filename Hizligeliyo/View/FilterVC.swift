//
//  FilterVC.swift
//  Hizligeliyo
//
//  Created by Noyan Çepikkurt on 30.11.2022.
//

import UIKit

class FilterVC: UIViewController {
    
    private var ItemListViewModel : ItemsListViewModel!

    @IBOutlet weak var tableView: UITableView!
   
    var categoryArray : [String] = ["men's clothing","jewelery","electronics","women's clothing"]
    var selectedCategory = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.topItem?.title = " KATEGORİLER"
        
    }
}

extension FilterVC:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = categoryArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProductListVCFromFilterVC" {
            let destinationVC = segue.destination as! ProductListVC
            destinationVC.selectedCell = selectedCategory
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategory = categoryArray[indexPath.row]
        performSegue(withIdentifier: "toProductListVCFromFilterVC", sender: nil)
    }
}
