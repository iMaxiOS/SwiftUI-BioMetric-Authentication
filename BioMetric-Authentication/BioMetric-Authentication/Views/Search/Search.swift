//
//  Search.swift
//  BioMetric-Authentication
//
//  Created by Maxim Granchenko on 09.12.2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct Search: View {
    
    @ObservedObject var RandomImages = GetData()
    @State var expand = false
    @State var search = ""
    @State var page = 1
    @State var isSearching = false
    
    var body: some View {
        
        VStack(spacing: 0) {
            HStack {
                
                if !self.expand {
                    VStack(alignment: .leading, spacing: 8, content: {
                        Text("UnSplash")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Text("Beautiful, Free Photos")
                            .font(.caption)
                    })
                    .foregroundColor(.black)
                }
                
                Spacer(minLength: 0)
                
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .onTapGesture {
                        withAnimation {
                            self.expand = true
                        }
                    }
                
                if self.expand {
                    TextField("Search....", text: $search)
                    
                    if self.search != "" {
                        Button(action: {
                            self.RandomImages.Images.removeAll()
                            self.isSearching = true
                            self.page = 1
                            self.searchData()
                        }, label: {
                            Text("Find")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        })
                    }
                    
                    Button(action: {
                        withAnimation {
                            self.expand = false
                            self.search = ""
                        }
                        
                        if self.isSearching {
                            self.isSearching = false
                            self.RandomImages.Images.removeAll()
                            self.RandomImages.updateData()
                        }
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.black)
                    })
                }
            }
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            .padding()
            .background(Color.white)
            
            Spacer(minLength: 0)
            
            if RandomImages.Images.isEmpty {
                
                if RandomImages.notResult {
                    Text("No Results Found")
                } else {
                    Indicator()
                }
                
                Spacer(minLength: 0)
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 15) {
                        ForEach(self.RandomImages.Images, id: \.self) { i in
                            HStack(spacing: 20) {
                                ForEach(i) { j in
                                    AnimatedImage(url: URL(string: j.urls["thumb"]!))
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: (UIScreen.main.bounds.width - 50) / 2, height: 200)
                                        .cornerRadius(16)
                                        .contextMenu {
                                            Button {
                                                SDWebImageDownloader()
                                                    .downloadImage(with: URL(string: j.urls["small"]!)) { (image, _, _, _) in
                                                        guard let image = image else { return }

                                                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                                                }
                                            } label: {
                                                HStack {
                                                    Text("Save")
                                                    Spacer(minLength: 0)
                                                    Image(systemName: "square.and.arrow.down.fill")
                                                }
                                                .foregroundColor(.black)
                                            }
                                        }
                                }
                            }
                        }
                        
                        if !self.RandomImages.Images.isEmpty {
                            if self.isSearching && self.search != "" {
                                HStack {
                                    Text("Page \(self.page)")
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                    
                                    Spacer(minLength: 0)
                                    
                                    Button {
                                        self.RandomImages.Images.removeAll()
                                        self.page += 1
                                        self.searchData()
                                    } label: {
                                        Text("Next")
                                            .fontWeight(.bold)
                                            .foregroundColor(.black)
                                    }
                                }
                                .frame(height: 40)
                                .padding(.horizontal, 25)
                                .padding(.vertical)
                            } else {
                                HStack {
                                    Spacer(minLength: 0)
                                    
                                    Button {
                                        self.RandomImages.Images.removeAll()
                                        self.RandomImages.updateData()
                                    } label: {
                                        Text("Next")
                                            .fontWeight(.bold)
                                            .foregroundColor(.black)
                                    }
                                }
                                .frame(height: 40)
                                .padding(.horizontal, 25)
                                .padding(.vertical)
                            }
                        }
                    }
                    .padding(.top)
                }
            }
        }
        .background(Color.black.opacity(0.07).ignoresSafeArea(.all, edges: .all))
        .edgesIgnoringSafeArea(.top)
    }
    
    func searchData() {
        let key = "8-P1bmWwuQrVZ2UvKX_LFoYpbY49BY4NJkLIqRwffOI"
        let query = self.search.replacingOccurrences(of: " ", with: "%20")
        let url = "https://api.unsplash.com/search/photos/?page=\(self.page)&query=\(query)&client_id=\(key)"
        
        RandomImages.searchData(url: url)
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
