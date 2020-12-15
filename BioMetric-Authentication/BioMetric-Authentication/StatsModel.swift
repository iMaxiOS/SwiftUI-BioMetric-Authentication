//
//  StatsModel.swift
//  BioMetric-Authentication
//
//  Created by Maxim Granchenko on 15.12.2020.
//

import SwiftUI

struct Stats : Identifiable {
    var id : Int
    var title : String
    var currentData : CGFloat
    var goal : CGFloat
    var color : Color
}
