//
//  GirlsTableViewCell.swift
//  GankIO
//
//  Created by 河图。 on 16/3/6.
//  Copyright © 2016年 Study. All rights reserved.
//

import UIKit

class GirlsTableViewCell: UITableViewCell
{
  
  @IBOutlet weak var cardView: UIView! {
    didSet {
      cardView.layer.cornerRadius = 10
      cardView.layer.masksToBounds = true
    }
  }
  
  @IBOutlet weak var girlImageView: UIImageView! {
    didSet {
//      girlImageView.layer.masksToBounds = true
    }
  }
}
