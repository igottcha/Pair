//
//  PairListTableViewController.swift
//  Pair
//
//  Created by Chris Gottfredson on 4/10/20.
//  Copyright © 2020 Gottfredson. All rights reserved.
//

import UIKit

class PairListTableViewController: UITableViewController {

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PairController.shared.loadNamesFromPersistentStore()
    }

    //MARK: - Actions
    
    @IBAction func addNameButtonTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Person", message: "Add someone new to the list.", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Full Name"
            textField.autocorrectionType = .yes
            textField.autocapitalizationType = .sentences
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addPersonAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let name = alert.textFields?.first?.text, !name.isEmpty else { return }
            PairController.shared.names.append(name)
            PairController.shared.saveNamesToPersistentStore()
            self.tableView.reloadData()
        }
        alert.addAction(cancelAction)
        alert.addAction(addPersonAction)
        
        self.present(alert, animated: true)
    }
    
    @IBAction func randomizeButtonTapped(_ sender: UIButton) {
        PairController.shared.shuffleAndRandomize()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return PairController.shared.pairs.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PairController.shared.pairs[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)
        let name = PairController.shared.pairs[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = name

        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group \(section + 1)"
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}
