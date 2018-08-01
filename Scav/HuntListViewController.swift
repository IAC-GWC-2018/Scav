//
//  HuntListViewController.swift
//  Scav
//
//  Created by Mayki Hu on 7/11/18.
//  Copyright © 2018 GirlsWhoCode. All rights reserved.
//

import UIKit

class HuntListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var hunts = Hunt.testHunts()
    
    static func create() -> HuntListViewController {
        return self.init(nibName: String(describing: self.self), bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureTableView()
        createAddHuntButton()
        self.title = "Hunt List"
    }
    
    private func configureTableView() {
        tableView.dataSource = (self as? UITableViewDataSource)
        tableView.delegate = self as? UITableViewDelegate
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.green.withAlphaComponent(0.2)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(UINib(nibName: String(describing: HuntListTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: HuntListTableViewCell.self))
    }
    
    private func createAddHuntButton() {
        let addButton = UIButton(type: .contactAdd)
        addButton.setTitle("  Create", for: .normal)
        addButton.contentHorizontalAlignment = .left
        let addButtonItem = UIBarButtonItem(customView: addButton)
        addButton.addTarget(self, action:#selector(self.showHuntCreation), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = addButtonItem
    }
    
    @objc private func showHuntCreation() {
        let creationVC = HuntCreationViewController.create()
        present(creationVC, animated: true)
    }
    
        // Do any additional setup if required.
    
    
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


