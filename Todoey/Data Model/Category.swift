//
//  Category.swift
//  Todoey
//
//  Created by Amit Vaidya on 10/06/18.
//  Copyright © 2018 Tech Navigator. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    let items = List<Item>()
}
