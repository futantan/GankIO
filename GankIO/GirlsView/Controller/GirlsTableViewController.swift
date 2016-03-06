//
//  GirlsTableViewController.swift
//  GankIO
//
//  Created by 河图。 on 16/3/6.
//  Copyright © 2016年 Study. All rights reserved.
//

import UIKit

class GirlsViewController: UIViewController
{
  
  @IBOutlet weak var girlsTableView: UITableView! {
    didSet {
      girlsTableView.dataSource = self
      girlsTableView.delegate = self
    }
  }
  
  private struct Names {
    static let nibName = "GirlsTableViewCell"
    static let girlsTableViewCellName = "girlsTableViewCell"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    girlsTableView.registerNib(UINib(nibName: Names.nibName, bundle: nil), forCellReuseIdentifier: Names.girlsTableViewCellName)
  }
}

extension GirlsViewController: UITableViewDataSource
{
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(Names.girlsTableViewCellName) as! GirlsTableViewCell
    return cell
  }
}

extension GirlsViewController: UITableViewDelegate {
  func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
    return nil
  }
}