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
  
  var visited = [Bool]()
  
  private struct GirlsViewNames {
    static let nibName = "GirlsTableViewCell"
    static let girlsTableViewCellName = "girlsTableViewCell"
    static let girlsImageUrlString = "http://gank.io/api/data/福利/100/1"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initVisitedArray()
    
    model = GankModel()
    model.getAlamofireFromString(GirlsViewNames.girlsImageUrlString)
    girlsTableView.registerNib(UINib(nibName: GirlsViewNames.nibName, bundle: nil), forCellReuseIdentifier: GirlsViewNames.girlsTableViewCellName)
  }
  
  func initVisitedArray() {
    for _ in 1...100 {
      visited.append(false)
    }
  }
}

extension GirlsViewController: UITableViewDataSource
{
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 100
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(GirlsViewNames.girlsTableViewCellName) as! GirlsTableViewCell
    if model.gankDailys.count != 0 {
        let urlString = self.model.gankDailys[indexPath.row].url
      cell.girlImageView.kf_setImageWithURL(NSURL(string: urlString)!)
      cell.girlImageView.contentMode = .ScaleAspectFill
      cell.girlImageView.clipsToBounds = true
      cell.nameLabel.text = self.model.gankDailys[indexPath.row].who
      cell.dateLabel.text = self.model.gankDailys[indexPath.row].creatAt
      UIView.animateWithDuration(0.5) {
        cell.girlImageView.alpha = 1.0
        cell.contentView.alpha = 1.0
      }
      if visited[indexPath.row] == false {
        cell.center.y += cell.bounds.height / 3
        UIView.animateWithDuration(0.5) {
          cell.center.y -= cell.bounds.height / 3
        }
        visited[indexPath.row] = true
      }
    } else {
      cell.girlImageView.alpha = 0
      cell.contentView.alpha = 0
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