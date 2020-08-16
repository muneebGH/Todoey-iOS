//
//  TodoListViewController.swift
//  Todoey


import UIKit

class TodoListViewController: UITableViewController{
    
    //runtume array to be displayed
    var itemArray=[Item]()
    //defaults for storing key value pairs
    let defaults=UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let newItem=Item()
        newItem.title="Eat something"
        itemArray.append(newItem)
        
        let newItem2=Item()
        newItem2.title="learn iOS"
        itemArray.append(newItem2)
        
        let newItem3=Item()
        newItem3.title="laugh like a pro"
        itemArray.append(newItem3)
        if let item=defaults.array(forKey: "TodoListArray") as? [Item]{
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
        let item=itemArray[indexPath.row]
        cell.textLabel?.text=item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }

    
    
    //MARK: - TableView delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //cell selection listener
 
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
      
        tableView.cellForRow(at: indexPath)
        tableView.reloadData()
      
        tableView.deselectRow(at: indexPath, animated: true)
    }

    

    //MARK: - Add new items
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
    
        var textField=UITextField()
        let alert=UIAlertController(title: "Add New Todo", message: "", preferredStyle: .alert)
        let action=UIAlertAction(title: "Add Item", style: .default) { (action) in
            //code what will happen
            if textField.text != ""{

                let newItem=Item()
                newItem.title=textField.text!
                self.itemArray.append(newItem)
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

