//
//  TabViewModel.swift
//  BioMetric-Authentication
//
//  Created by Maxim Granchenko on 09.12.2020.
//

import SwiftUI

class TabViewModel: ObservableObject {
    @Published var selectedItem: Item!
    @Published var isDetail = false
}
