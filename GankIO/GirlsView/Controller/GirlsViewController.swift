//
//  GirlsTableViewController.swift
//  GankIO
//
//  Created by 河图。 on 16/3/6.
//  Copyright © 2016年 Study. All rights reserved.
//

import UIKit
import Kingfisher

class GirlsViewController: UIViewController {
  @IBOutlet weak var girlsTableView: UITableView! {
    didSet {
      girlsTableView.dataSource = self
      girlsTableView.delegate = self
    }
  }
  
  var model = GankModel() {
    didSet {
      print("model set many times")
      model.delegate = self
    }
  }
  
  var visited = [Bool](count: 100, repeatedValue: false)
  
  
  // TODO: - 网络请求分页
  private struct GirlsViewNames {
    static let nibName = "GirlsTableViewCell"
    static let girlsTableViewCellName = "girlsTableViewCell"
    static let girlsImageUrlString = "http://gank.io/api/data/福利/100/1"
    static let showGirlsDailyViewSegueIdentifier = "showGirlsDailyView"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    initVisitedArray()
    setUpNavigatonBar()
    
    model = GankModel()
    model.getAlamofireFromString(GirlsViewNames.girlsImageUrlString)
    girlsTableView.registerNib(UINib(nibName: GirlsViewNames.nibName, bundle: nil), forCellReuseIdentifier: GirlsViewNames.girlsTableViewCellName)
  }
  
  // TODO: - 不要以 init 开头 这是 OC 时代的特定方法
  // TODO: - 这种方式效率太差
//  func initVisitedArray() {
//    for _ in 1...100 {
//      visited.append(false)
//    }
//  }
  
  func setUpNavigatonBar() {
    self.view.tintColor = UIColor.whiteColor()
    if let controller = self.navigationController {
      controller.navigationBar.barTintColor = UIColor(red:0.29, green:0.35, blue:0.5, alpha:1)
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let identifies = segue.identifier {
      switch identifies {
      case GirlsViewNames.showGirlsDailyViewSegueIdentifier:
        let controller = segue.destinationViewController as! GirlsDailyViewController
        let indexPath = sender as! NSIndexPath
        let date = model.gankDailys[indexPath.row].getDate()
        controller.girlsDailyDate = date
      default: break
      }
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
      setUpCell(cell, indexPath: indexPath)
      UIView.animateWithDuration(0.2) {
        cell.girlImageView.alpha = 1.0
        cell.contentView.alpha = 1.0
      }
      if visited[indexPath.row] == false {
        cell.center.y += cell.bounds.height / 3
        UIView.animateWithDuration(0.2) {
          cell.center.y -= cell.bounds.height / 3
        }
        visited[indexPath.row] = true
      }
    } else {
      cell.cardView.alpha = 0
    }
    return cell
  }
  
  // TODO: - move this to GirlsTableViewCell
  func setUpCell(cell: GirlsTableViewCell, indexPath: NSIndexPath) {
    cell.cardView.alpha = 1.0
    let urlString = self.model.gankDailys[indexPath.row].url
    cell.girlImageView.kf_setImageWithURL(NSURL(string: urlString)!)
    cell.girlImageView.contentMode = .ScaleAspectFill
    cell.girlImageView.clipsToBounds = true
    cell.nameLabel.text = model.gankDailys[indexPath.row].who
    cell.dateLabel.text = model.gankDailys[indexPath.row].dateString
  }
}

extension GirlsViewController: UITableViewDelegate
{
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    performSegueWithIdentifier(GirlsViewNames.showGirlsDailyViewSegueIdentifier, sender: indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
}

extension GirlsViewController: GankModelDelegate
{
  func gankModelDidGetAlamofire() {
    girlsTableView.reloadData()
  }
}