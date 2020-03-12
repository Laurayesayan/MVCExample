//
//  CategoriesModel.swift
//  MVCExample_2_4
//
//  Created by Лаура Есаян on 12.03.2020.
//  Copyright © 2020 LY. All rights reserved.
//

import Foundation

struct Categories {
    let name: String
    let iconImage: String
    
    init?(data: NSDictionary) {
        guard let name = data["name"] as? String,
            let iconImage = data["iconImage"] as? String else {
                return nil
        }
        
        self.name = name
        self.iconImage = iconImage
    }
}
