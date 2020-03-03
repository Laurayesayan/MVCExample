//
//  ViewController.swift
//  MVCExample_2_4
//
//  Created by Лаура Есаян on 03.03.2020.
//  Copyright © 2020 LY. All rights reserved.
//

import UIKit

import Foundation

import Bond

import Alamofire

import Kingfisher

class ViewController: UIViewController {
    @IBOutlet weak var categoriesTableView: UITableView!
    let categoriesViewModel = CategoriesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindCategoriesToTableView()
        categoriesViewModel.loadCategories(url: "http://blackstarshop.ru/index.php?route=api/v1/categories")
    }
    
    func bindCategoriesToTableView() {
        categoriesViewModel.categoriesList.bind(to: categoriesTableView) { (dataSource, indexPath, tableView) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesCell") as! CategoriesTableViewCell
            
            cell.titleLabel.text = dataSource[indexPath.row].name
            
            var url = URL(string: "http://blackstarshop.ru/\(dataSource[indexPath.row].iconImage)")
            
            // При отсутствии картинки вставялем дефолтную
            if dataSource[indexPath.row].iconImage.isEmpty {
                url = URL(string: "http://blackstarshop.ru/image/catalog/style/modile/acc_cat.png")
            }
            
            cell.iconImageView.kf.setImage(with: url)
            
            return cell
        }.dispose(in: reactive.bag)
    }


}

class CategoriesTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
}

class CategoriesViewModel {
    public var categoriesList = MutableObservableArray<Categories>([])
    
    func loadCategories(url: String) {
        AF.request(url).responseJSON {
            response in
            if let json = response.value,
                let jsonDict = json as? NSDictionary {
                for (_, data) in jsonDict {
                    if let categories = Categories(data: data as! NSDictionary) {
                        self.categoriesList.append(categories)
                    }
                }
            }
        }
    }
    
}

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
