//
//  DynamicTableViewController.swift
//  DynamicTableViewExample
//
//  Created by AJ Bartocci on 5/11/20.
//  Copyright © 2020 AJ Bartocci. All rights reserved.
//

import UIKit

class DynamicTableViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    
    var tableManager: DynamicTableViewManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableManager = DynamicTableViewManager(tableView: tableView)
        
        // let the tablemanger handle the hard stuff of the tableview
        // and delegate the stuff we care about back to us
        tableView.separatorStyle = .none
        tableManager.delegate = self
        tableView.reloadData()

        // Do any additional setup after loading the view.
    }

}

// this would also delegate interactions that we care about from any of our table elements 
extension DynamicTableViewController: DynamicTableViewManagerDelegate {
    
//    func reloadIndexPath(_ indexPath: IndexPath) {
//        tableView.reloadRows(at: [indexPath], with: .fade)
//    }
    
    func insertIndexPath(_ indexPath: IndexPath) {
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func removeIndexPath(_ indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
