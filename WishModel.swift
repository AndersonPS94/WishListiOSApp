//
//  WishModel.swift
//  WishList
//
//  Created by Anderson Pereira Dos Santos on 24/08/25.
//

import Foundation
import SwiftData

@Model
class Wish {
var title: String
    
    init(title:String) {
        self.title = title
    }
}
