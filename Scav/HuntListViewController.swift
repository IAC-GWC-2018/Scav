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
    private let refreshControl = UIRefreshControl()
    var hunts = [Hunt]()

    static func create() -> HuntListViewController {
        return self.init(nibName: String(describing: self.self), bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        createAddHuntButton()
        self.title = "Hunt List"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "GujaratiSangamMN-Bold", size: 20.0)!]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchHunts()
    }
    
    @objc private func fetchHunts() {

        HuntNetworkManager.shared.process(.getHunts) { (data, _, _) in
            guard let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []),
                let jsonArray = json as? [[AnyHashable: AnyHashable]] else {
                    //present alert that there was an error
                    return
            }
            
            let decoder = JSONDecoder()
            var newHunts = Hunt.testHunts()
            let parsedHunts: [Hunt] = jsonArray.compactMap { decoder.parse(from: $0) }
            newHunts.append(contentsOf: parsedHunts)
            self.hunts = newHunts
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }

    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(red: 132 / 255, green: 254 / 255, blue: 235 / 255, alpha: 0.8)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(UINib(nibName: String(describing: HuntListTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: HuntListTableViewCell.self))
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(fetchHunts), for: .valueChanged)
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
    
}

extension HuntListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hunts.count
    }

    private func customizeCell(_ cell: HuntListTableViewCell) {
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = CGFloat(10)
        cell.layer.borderColor = tableView.backgroundColor?.cgColor
        cell.huntNameLabel.font = UIFont(name: "GujaratiSangamMN-Bold", size: 20.0)
        cell.huntDescriptionLabel.font = UIFont(name: "GujaratiSangamMN", size: 14.0)
    }

    private func insertHuntData(_ cell: HuntListTableViewCell, cellForRowAt indexPath: IndexPath) {
        let hunt = hunts[indexPath.row]
        cell.huntNameLabel.text = hunt.title
        cell.huntDescriptionLabel.text = hunt.description
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HuntListTableViewCell.self)) as? HuntListTableViewCell else {
            return UITableViewCell()
        }

        customizeCell(cell)
        insertHuntData(cell, cellForRowAt: indexPath)

        return cell
    }
    
}

extension HuntListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hunt = hunts[indexPath.row]
        let mapVC = HuntMapViewController.create(hunt: hunt)
        present(mapVC, animated: true)
    }
}
