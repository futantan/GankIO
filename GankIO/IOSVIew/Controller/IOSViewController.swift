//
//  IOSViewController.swift
//  GankIO
//
//  Created by 河图。 on 16/3/6.
//  Copyright © 2016年 Study. All rights reserved.
//

import UIKit

class IOSViewController: UIViewController
{
  @IBOutlet weak var iOSTableView: UITableView! {
    didSet {
      iOSTableView.delegate = self
      iOSTableView.dataSource = self
    }
  }
  
  var model = GankModel() {
    didSet {
      model.delegate = self
    }
  }
  
  private struct IOSViewNames {
    static let iOSTableViewCellIdentifier = "iOSTableViewCell"
    static let iOSGankUrlString = "http://gank.io/api/data/iOS/100/2"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    model = GankModel()
    model.getAlamofireFromString(IOSViewNames.iOSGankUrlString)
    
    iOSTableView.registerNib(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: IOSViewNames.iOSTableViewCellIdentifier)
  }
}

extension IOSViewController: UITableViewDelegate
{
  
}

extension IOSViewController: UITableViewDataSource
{
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 100
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = iOSTableView.dequeueReusableCellWithIdentifier(IOSViewNames.iOSTableViewCellIdentifier) as! MyTableViewCell
    if model.gankDailys.count != 0 {
      cell.titleLabel.text = model.gankDailys[indexPath.row].desc
      cell.nameLabel.text = model.gankDailys[indexPath.row].who
      cell.titleLabel.alpha = 0
      cell.nameLabel.alpha = 0
      UIView.animateWithDuration(1.0) {
        cell.titleLabel.alpha = 1.0
        cell.nameLabel.alpha = 1.0
      }
    }
    return cell
  }
}

extension IOSViewController: GankModelDelegate {
  func gankModelDidGetAlamofire() {
    iOSTableView.reloadData()
  }
}