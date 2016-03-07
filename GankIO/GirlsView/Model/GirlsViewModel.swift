//
//  GirlsViewModel.swift
//  GankIO
//
//  Created by 河图。 on 16/3/7.
//  Copyright © 2016年 Study. All rights reserved.
//

import Foundation
import Alamofire

class GirlsViewModel
{
  var gankDailys = [GankDaily]()
  
  func getAlamofire() {
    let string = "http://gank.io/api/data/福利/1/1"
    let url = string.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet(charactersInString: string))
    print(url)
    Alamofire.request(.GET, url!).responseJSON() {
       response in
      
      if let JSON = response.result.value {
        print("JSON: \(JSON)")
      }
    }
  }
}