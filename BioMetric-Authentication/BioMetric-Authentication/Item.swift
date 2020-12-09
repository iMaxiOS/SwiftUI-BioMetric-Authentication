//
//  Item.swift
//  BioMetric-Authentication
//
//  Created by Maxim Granchenko on 09.12.2020.
//

import SwiftUI

struct Item: Identifiable {
    var id = UUID().uuidString
    var title: String
    var price: String
    var discont: String
    var image: String
}
