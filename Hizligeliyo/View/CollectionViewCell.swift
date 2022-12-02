//
//  CollectionViewCell.swift
//  Hizligeliyo
//
//  Created by Noyan Çepikkurt on 28.11.2022.
//

import UIKit
import SDWebImage

final class CollectionViewCell: UICollectionViewCell{
    
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var  itemTitleLabel: UILabel!
    @IBOutlet weak private var itemPriceLabel: UILabel!
    
    func load(with itemsModel : ItemsModel!) {
        if let imageUrl = itemsModel.image {
            self.imageView.sd_setImage(with: URL(string: imageUrl))
        }
        self.itemTitleLabel.text = itemsModel.title
        self.itemPriceLabel.text = "\(itemsModel.price)" + " TL"
    }
    
}



