//
//  StaticTextTableElement.swift
//  DynamicTableViewExample
//
//  Created by AJ Bartocci on 5/11/20.
//  Copyright © 2020 AJ Bartocci. All rights reserved.
//

import UIKit

final class StaticTextTableElement: DynamicTableElement {
    
    let cellId = "StaticTextTableElement.cellId"
    
    init(tableView: UITableView) {
        register(tableView: tableView)
    }
    
    func register(tableView: UITableView) {
        let nib = UINib(
            nibName: "TextTableViewCell",
            bundle: Bundle(for: TextTableViewCell.self)
        )
        tableView.register(nib, forCellReuseIdentifier: cellId)
    }
    
    func cellForRow(at indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TextTableViewCell
        return cell
    }
}

