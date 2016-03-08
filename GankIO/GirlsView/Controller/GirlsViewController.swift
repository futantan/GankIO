//
//  GirlsTableViewController.swift
//  GankIO
//
//  Created by 河图。 on 16/3/6.
//  Copyright © 2016年 Study. All rights reserved.
//

import UIKit
import Kingfisher

class GirlsViewController: UIViewController
{
  @IBOutlet weak var girlsTableView: UITableView! {
    didSet {
      girlsTableView.dataSource = self
      girlsTableView.delegate = self
    }
  }
  
  var model = GankModel() {
    didSet {
      model.delegate = self
    }
  }
  
  private struct Names {
    static let nibName = "GirlsTableViewCell"
    static let girlsTableViewCellName = "girlsTableViewCell"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    model = GankModel()
    model.getAlamofire()
    girlsTableView.registerNib(UINib(nibName: Names.nibName, bundle: nil), forCellReuseIdentifier: Names.girlsTableViewCellName)
  }
}

extension GirlsViewController: UITableViewDataSource
{
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 100
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(Names.girlsTableViewCellName) as! GirlsTableViewCell
    if model.gankDailys.count != 0 {
        let urlString = self.model.gankDailys[indexPath.row].url
      cell.girlImageView.kf_setImageWithURL(NSURL(string: urlString)!)
      cell.girlImageView.contentMode = .ScaleAspectFill
      cell.girlImageView.clipsToBounds = true
      cell.nameLabel.text = self.model.gankDailys[indexPath.row].who
      cell.dateLabel.text = self.model.gankDailys[indexPath.row].creatAt
      UIView.animateWithDuration(1) {
        cell.girlImageView.alpha = 1.0
        cell.contentView.alpha = 1.0
      }
    } else {
      cell.girlImageView.alpha = 0
      cell.contentView.alpha = 0
      print("is nil")
    }
    return cell
  }
}

extension GirlsViewController: UITableViewDelegate {
  func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
    return nil
  }
}

extension GirlsViewController: GankModelDelegate {
  func gankModelDidGetAlamofire() {
    girlsTableView.reloadData()
  }
}