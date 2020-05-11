//
//  DynamicTableViewManager.swift
//  DynamicTableViewExample
//
//  Created by AJ Bartocci on 5/11/20.
//  Copyright © 2020 AJ Bartocci. All rights reserved.
//

import UIKit

/*
 
 The main idea is that our state / dataSource drives each element of the table. There is a single source of truth that gets modified by interactions. This makes it pretty trivial to re-arrange objects since it all comes from a single place.
 
 There should always be a single source of truth, when individual components start to handle their own state things get messy quick.
 
 This example disregards sections completely, as we don't need sections for this simple table. This can be adapted to work with sections if needed
 
 */

protocol DynamicTableElement: class {
    init(tableView: UITableView)
    func register(tableView: UITableView)
    func cellForRow(at indexPath: IndexPath, tableView: UITableView) -> UITableViewCell
}

protocol DynamicTableViewManagerDelegate: class {
    func insertIndexPath(_ indexPath: IndexPath)
    func removeIndexPath(_ indexPath: IndexPath)
}

// DynamicTableViewManager serves as our single source of truth
class DynamicTableViewManager: NSObject {
    
    private var elements: [DynamicTableElement] = []
    
    weak var delegate: DynamicTableViewManagerDelegate!
    
    private let buttonElement: ButtonTableElement
    private let expandingElement: ExpandableTableElement
        
    init(tableView: UITableView) {
        self.expandingElement = ExpandableTableElement(tableView: tableView)
        self.buttonElement = ButtonTableElement(tableView: tableView)
        super.init()
        buttonElement.delegate = self
        elements.append(buttonElement)
        
        let textElement = StaticTextTableElement(tableView: tableView)
        elements.append(textElement)
        
//        elements.append(buttonElement)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension DynamicTableViewManager: ButtonTableElementDelegate {
    
    func didTapButton(
        at indexPath: IndexPath,
        element: ButtonTableElement
    ) {
        let expandedIndex = elements.firstIndex { (element) -> Bool in
            return element === expandingElement
        }
        if let row = expandedIndex {
            // we are expanded already so collapse
            elements.remove(at: row)
            delegate.removeIndexPath(IndexPath(row: row, section: 0))
        } else {
            // we are collapsed so expand
            let buttonIndex = elements.firstIndex { (element) -> Bool in
                return element === buttonElement
            }
            guard let row = buttonIndex else {
                return
            }
            let newRow = row + 1
            elements.insert(expandingElement, at: newRow)
            delegate.insertIndexPath(IndexPath(row: newRow, section: 0))
        }
    }
}

extension DynamicTableViewManager: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return elements.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let element = elements[indexPath.row]
        return element.cellForRow(at: indexPath, tableView: tableView)
    }
}

extension DynamicTableViewManager: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        print("did select row at \(indexPath)")
    }
}
