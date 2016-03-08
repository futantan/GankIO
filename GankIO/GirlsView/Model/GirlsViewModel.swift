//
//  GirlsViewModel.swift
//  GankIO
//
//  Created by 河图。 on 16/3/7.
//  Copyright © 2016年 Study. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class GirlsViewModel
{
  var gankDailys = [GankDaily]()
  
  func getAlamofire() {
    let string = "http://gank.io/api/data/福利/1/1"
    let url = string.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet(charactersInString: string))
    print(url)
    Alamofire.request(.GET, url!).responseJSON() {
      response in
      if let data = response.result.value {
        let json = JSON(data)
        print(json["results"][0]["who"].string)
      }
    }
  }
  
  func dictionaryFromJSONString(JSONString: String) {
    
  }
  
}