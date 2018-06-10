//
//  Item.swift
//  Todoey
//
//  Created by Amit Vaidya on 10/06/18.
//  Copyright © 2018 Tech Navigator. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    // var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
