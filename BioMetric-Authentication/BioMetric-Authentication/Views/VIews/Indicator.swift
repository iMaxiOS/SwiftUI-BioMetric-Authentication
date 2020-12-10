//
//  Indicator.swift
//  BioMetric-Authentication
//
//  Created by Maxim Granchenko on 10.12.2020.
//

import SwiftUI

struct Indicator: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        
    }
}
