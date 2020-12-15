//
//  RoundShape.swift
//  BioMetric-Authentication
//
//  Created by Maxim Granchenko on 15.12.2020.
//

import SwiftUI

struct RoundShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: 5, height: 5)
        )
        
        return Path(path.cgPath)
    }
}
