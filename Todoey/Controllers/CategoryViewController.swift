//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Amit Vaidya on 09/06/18.
//  Copyright © 2018 Tech Navigator. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {

    let realm = try! Realm()
    var categories: Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        tableView.separatorStyle = .none
        
    }
    //MARK: - tableview datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1 //Nil coalescing operator used
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let category = categories?[indexPath.row] {
            
        cell.textLabel?.text = category.name
        guard let categoryColor = UIColor(hexString: category.color) else {fatalError()}
        cell.backgroundColor = categoryColor
        cell.textLabel?.textColor = ContrastColorOf(categoryColor, returnFlat: true)
        }
        return cell
    }
    //MARK: - tableView delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }

    //MARK: - data manipulation methods
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("error saving context \(error)")
        }
        tableView.reloadData()
    }
   func loadCategories() {
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    //MARK: - delete data from swipe
    override func updateModel(at indexPath: IndexPath) {
        //super.updateModel(at: indexPath)
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("error saving done")
            }
        }
    }
    
    
    //MARK: - add new categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in

            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.color = UIColor.randomFlat.hexValue()
            self.save(category: newCategory)
        }
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add new category"
            }
        
        
        present(alert, animated: true, completion: nil)
    }

}

