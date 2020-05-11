//
//  ExpandableTableElement.swift
//  DynamicTableViewExample
//
//  Created by AJ Bartocci on 5/11/20.
//  Copyright © 2020 AJ Bartocci. All rights reserved.
//

import UIKit

final class ExpandableTableElement: DynamicTableElement {
    
    let cellId = "ExpandableTableElement.cellId"
    
    init(tableView: UITableView) {
        register(tableView: tableView)
    }
    
    func register(tableView: UITableView) {
        let nib = UINib(
            nibName: "ExpandableTableViewCell",
            bundle: Bundle(for: ExpandableTableViewCell.self)
        )
        tableView.register(nib, forCellReuseIdentifier: cellId)
    }
    
    func cellForRow(at indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ExpandableTableViewCell
        return cell
    }
}
