//
//  TodoListViewController.swift
//  Todoey


import UIKit

class TodoListViewController: UITableViewController{
    
    //runtume array to be displayed
    var itemArray=["go to bank","go to doctor","weight yourself","do something"]
    //defaults for storing key value pairs
    let defaults=UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if let item=defaults.array(forKey: "TodoListArray") as? [String]{
            itemArray=item
        }
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - TableView DataSource methods
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return count of rows in table to display
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //called each time for every row
        //get a cell
        //edit and return
        let cell=tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text=itemArray[indexPath.row]
        print(indexPath)
        return cell
    }

    
    
    //MARK: - TableView delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //cell selection listener
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    

    //MARK: - Add new items
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
    
        var textField=UITextField()
        let alert=UIAlertController(title: "Add New Todo", message: "", preferredStyle: .alert)
        let action=UIAlertAction(title: "Add Item", style: .default) { (action) in
            //code what will happen
            if textField.text != ""{

                self.itemArray.append(textField.text!)
                self.defaults.set(self.itemArray, forKey: "TodoListArray")
                self.tableView.reloadData()
            }
        }
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder="add something"
            textField=alertTextField
        }
        
        self.present(alert, animated: true, completion: nil)
    }
}

