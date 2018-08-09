//
//  CompletedHuntViewController.swift
//  Scav
//
//  Created by Chloe Gottleib on 8/8/18.
//  Copyright © 2018 GirlsWhoCode. All rights reserved.
//

import UIKit
//import Gifu
//import GiphyCoreSDK

protocol CompletedHuntDismissalDelegate: class {
    func dismiss()
}

class CompletedHuntViewController: UIViewController {

    @IBOutlet weak var congratsLabel: UILabel!
    @IBOutlet weak var destinationTableView: UITableView!
    // @IBOutlet weak var gifImageView: GIFImageView!
    @IBOutlet weak var completeButton: UIButton!
    private var hunt: Hunt?
    private weak var delegate: CompletedHuntDismissalDelegate?
//    let giphy = GiphyCore.configure(apiKey: "VnuYbTyWtU0w20UvTREyvZNAyvBF59jw")
    
    static func create(hunt: Hunt, delegate: CompletedHuntDismissalDelegate) -> CompletedHuntViewController {
        let vc = CompletedHuntViewController(nibName: String(describing: self.self), bundle: nil)
        vc.hunt = hunt
        vc.delegate = delegate
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        guard let hunt = hunt else {
            return
        }
        
        let message = "Congrats! You've completed \(hunt.title)!"
        congratsLabel.text = message
        
        configureTableView()
        configureButton()
//        showGif()
    }
    
//    private func showGif() {
//        GiphyCore.shared.random("congrats") { (response, error) in
//
//            if let response = response, let data = response.data  {
//                print(response.meta)
//                print(data)
//            }
//        }
//    }
    private func configureTableView() {
        destinationTableView.dataSource = self
        destinationTableView.rowHeight = UITableViewAutomaticDimension
        destinationTableView.register(UINib(nibName: String(describing: HuntLocationTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: HuntLocationTableViewCell.self))
        
        
    }
    
    private func configureButton() {
        let buttonTitle = "Choose another hunt"
        completeButton.setTitle(buttonTitle, for: UIControlState.normal)
    }
    
    @IBAction func completeButtonPress(_ sender: Any) {
        dismiss(animated: true) {
            self.delegate?.dismiss()
        }
    }
}

extension CompletedHuntViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HuntLocationTableViewCell.self)) as? HuntLocationTableViewCell else {
            return UITableViewCell()
        }
        
        configure(cell: cell, at: indexPath)
        return cell
    }
    
    private func configure(cell: HuntLocationTableViewCell, at indexPath: IndexPath) {
        guard let destination = hunt?.destinations[indexPath.row] else {
            return
        }
        
        cell.cellLocationTextLabel.text = "\(indexPath.row + 1)"
        cell.cellLocationNameLabel.text = destination.title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hunt?.destinations.count ?? 0
    }
}
