//
//  ButtonTableElement.swift
//  DynamicTableViewExample
//
//  Created by AJ Bartocci on 5/11/20.
//  Copyright © 2020 AJ Bartocci. All rights reserved.
//

import UIKit

protocol ButtonTableElementDelegate: class {
    func didTapButton(at indexPath: IndexPath, element: ButtonTableElement)
}

final class ButtonTableElement: DynamicTableElement {
    
    let cellId = "ButtonTableElement.cellId"
    weak var delegate: ButtonTableElementDelegate!
    
    init(tableView: UITableView) {
        register(tableView: tableView)
    }
    
    func register(tableView: UITableView) {
        let nib = UINib(
            nibName: "ButtonTableViewCell",
            bundle: Bundle(for: ButtonTableViewCell.self)
        )
        tableView.register(nib, forCellReuseIdentifier: cellId)
    }
    
    func cellForRow(at indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ButtonTableViewCell
        cell.onButtonTap = { [weak self] in
            self?.handleTap(indexPath: indexPath)
        }
        return cell
    }
    
    private func handleTap(indexPath: IndexPath) {
        self.delegate.didTapButton(at: indexPath, element: self)
    }

}
