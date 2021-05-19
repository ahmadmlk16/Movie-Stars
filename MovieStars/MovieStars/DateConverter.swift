//
//  DateConverter.swift
//  MovieStars
//
//  Created by Ahmad on 5/5/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import Foundation
import SwiftUI

func getDate(stringDate : String) -> String{
    let stringDate = stringDate
     
    // Create an instance of DateFormatter
    let dateFormatter = DateFormatter()
     
    // Set the date format to yyyy-MM-dd
    dateFormatter.dateFormat = "yyyy-MM-dd"
    dateFormatter.locale = Locale(identifier: "en_US")
     
    // Convert date String from "yyyy-MM-dd" to Date struct
    let dateStruct = dateFormatter.date(from: stringDate)
     
    // Create a new instance of DateFormatter
    let newDateFormatter = DateFormatter()
     
    newDateFormatter.locale = Locale(identifier: "en_US")
    newDateFormatter.dateStyle = .full      // Thursday, November 7, 2019
    newDateFormatter.timeStyle = .none
     
    // Obtain newly formatted Date String as "Thursday, November 7, 2019"
    let dateWithNewFormat = newDateFormatter.string(from: dateStruct!)
    
    return dateWithNewFormat.description
    
}
