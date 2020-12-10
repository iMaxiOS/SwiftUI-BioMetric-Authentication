//
//  SearchModel.swift
//  BioMetric-Authentication
//
//  Created by Maxim Granchenko on 10.12.2020.
//

import SwiftUI

//secret key YuilLPpmIQupylcT1e03d6qeNJOw1-3S7fgKRm-2wco



class GetData: ObservableObject {
    
    @Published var Images: [[SearchModel]] = []
    @Published var notResult = false
    
    init() {
        updateData()
    }
    
    func updateData() {
        
        notResult = false
        
        let key = "8-P1bmWwuQrVZ2UvKX_LFoYpbY49BY4NJkLIqRwffOI"
        let url = "https://api.unsplash.com/photos/random/?count=25&client_id=\(key)"
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!) { (data, _, error) in            
            guard let data = data, error == nil else { return }
            
            do {
                let json = try JSONDecoder().decode([SearchModel].self, from: data)
                
                for i in stride(from: 0, to: json.count, by: 2) {
                    var arrayData: [SearchModel] = []
                    for j in i..<i+2 {
                        if j < json.count {
                            arrayData.append(json[j])
                        }
                    }
                    DispatchQueue.main.async {
                        self.Images.append(arrayData)
                    }
                }
            } catch {
                print("🍎🍎🍎\(error.localizedDescription)")
            }
        }.resume()
    }
    
    func searchData(url: String) {
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!) { (data, _, error) in
            guard let data = data, error == nil else { return }
            
            do {
                let json = try JSONDecoder().decode(SearchPhoto.self, from: data)
                
                DispatchQueue.main.async {
                    if json.results.isEmpty {
                        self.notResult = true
                    } else {
                        self.notResult = false
                    }
                }
                
                for i in stride(from: 0, to: json.results.count, by: 2) {
                    var arrayData: [SearchModel] = []
                    for j in i..<i+2 {
                        if j < json.results.count {
                            arrayData.append(json.results[j])
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.Images.append(arrayData)
                    }
                }
            } catch {
                print("🍎🍎🍎\(error.localizedDescription)")
            }
        }.resume()
    }
}

struct SearchModel: Identifiable, Decodable, Hashable {
    var id: String
    var urls: [String: String]
}

struct SearchPhoto: Decodable {
    var results: [SearchModel]
}
