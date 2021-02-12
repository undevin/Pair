//
//  PairListViewController.swift
//  Pair
//
//  Created by Devin Flora on 2/12/21.
//

import UIKit

class PairListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PairController.shared.fetchPeople()
        tableView.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func addPersonButtonTapped(_ sender: Any) {
        displayAlertController()
    }
    
    @IBAction func randomizePersonButtonTapped(_ sender: UIButton) {
        PairController.shared.randomizeUsers()
        tableView.reloadData()
    }
    
    // MARK: - Methods
    func displayAlertController() {
        let alertController = UIAlertController(title: "Add Person", message: "Add a Person to the List", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Add name..."
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addButton = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let personName = alertController.textFields?[0].text, !personName.isEmpty else { return }
            PairController.shared.createUserWith(name: personName)
        }
        
        alertController.addAction(cancelButton)
        alertController.addAction(addButton)
        self.present(alertController, animated: true)
    }
}//End of Class

// MARK: - Extensions
extension PairListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PairController.shared.sections[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        for groupNumber in 0...25 {
            if section == groupNumber {
                return "Group \(groupNumber)"
            } else {
                return "Group"
            }
        }
        return "Group"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        let person = PairController.shared.sections[indexPath.section][indexPath.row]
        cell.textLabel?.text = person.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let personToDelete = PairController.shared.assignedUsers[indexPath.row]
            PairController.shared.delete(person: personToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}//End of Extension
