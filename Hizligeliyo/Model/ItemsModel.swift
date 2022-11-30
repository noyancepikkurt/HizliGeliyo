//
//  ItemsModel.swift
//  Hizligeliyo
//
//  Created by Noyan Çepikkurt on 28.11.2022.
//

import Foundation
import UIKit


struct ItemsModel : Decodable, Encodable {
    
    let id : Int
    let title : String
    let price : Float
    let description : String
    let category : String
    let image : String
    
}

