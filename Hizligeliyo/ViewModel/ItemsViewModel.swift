//
//  ItemsViewModel.swift
//  Hizligeliyo
//
//  Created by Noyan Çepikkurt on 29.11.2022.
//

import Foundation
import UIKit

struct ItemsListViewModel {
    var ItemsList : [ItemsModel]
    
    func numberOfItemsInSection() -> Int {
        return self.ItemsList.count
    }
    
    /* func ItemsAtIndex(_ index: Int) -> ItemsViewModel {
        var Item = self.ItemsList[index]
        return ItemsViewModel(Items: Item)
    } */
    
    // MVVM -> MVC?
}

struct ItemsViewModel {
    var Items : ItemsModel
    
    var id : Int? {
        return self.Items.id
    }
    var title : String? {
        return self.Items.title
    }
    var price : Float?{
        return self.Items.price
    }
    var description : String? {
        return self.Items.description
    }
    var category : String? {
        return self.Items.category
    }
    var image : String? {
        return self.Items.image
    }
}
 
