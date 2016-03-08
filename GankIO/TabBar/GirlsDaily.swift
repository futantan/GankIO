//
//  GankDaily.swift
//  GankIO
//
//  Created by 河图。 on 16/3/7.
//  Copyright © 2016年 Study. All rights reserved.
//

import Foundation

struct GankDaily
{
  var creatAt = ""
  var who = ""
  var url = ""
  
  mutating func dateFromString(string: String) {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
    let date = dateFormatter.dateFromString(cutStringToTimable(string))
    dateFormatter.dateFormat = "yyyy.MM.dd"
    if let date = date {
      creatAt = dateFormatter.stringFromDate(date)
    } else {
      creatAt = ""
    }
  }
  
  func cutStringToTimable(string: String) -> String {
    let index = string.startIndex.advancedBy(19)
    return string.substringToIndex(index)
  }
}