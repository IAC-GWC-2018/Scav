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
    
    var hunts = ["Ijoo", "Jenny", "Mayki"]
    
    static func create() -> HuntListViewController {
        return self.init(nibName: String(describing: self.self), bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureTableView()
        createAddHuntButton()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(UINib(nibName: String(describing: HuntListTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: HuntListTableViewCell.self))
    }
    
    private func createAddHuntButton() {
        let addButton = UIButton(type: .contactAdd)
        let addButtonItem = UIBarButtonItem(customView: addButton)
        addButton.addTarget(self, action:#selector(self.showHuntCreation), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = addButtonItem
    }
    
    @objc private func showHuntCreation() {
        print("show huntCreationController")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension HuntListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hunts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HuntListTableViewCell.self)) as? HuntListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.huntNameLabel.text = hunts[indexPath.row]
        cell.huntImageView.image = #imageLiteral(resourceName: "Mayki")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("show mapViewController")
    }
    
}

extension HuntListViewController: UITableViewDelegate {
    
}
