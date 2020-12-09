//
//  Weather.swift
//  BioMetric-Authentication
//
//  Created by Maxim Granchenko on 09.12.2020.
//

import SwiftUI

struct Weather: View {
    
    @State private var isNight = false
    @State private var isSmall = UIScreen.main.bounds.height >= 750
    
    @State var weathers = [
        WeatherItem(id: 0, image: "cloud.snow.fill", temperature: "-2º", dayOfWeek: "MON"),
        WeatherItem(id: 1, image: "sun.max.fill", temperature: "+5º", dayOfWeek: "TUE"),
        WeatherItem(id: 2, image: "wind.snow", temperature: "-12º", dayOfWeek: "WED"),
        WeatherItem(id: 3, image: "thermometer.snowflake", temperature: "-15º", dayOfWeek: "THU"),
        WeatherItem(id: 4, image: "cloud.sun.fill", temperature: "-10º", dayOfWeek: "FRI"),
    ]
    
    var body: some View {
        ZStack {
            GradientView(topColor: isNight ? .black : Color("lightBlue"), bottomColor: isNight ? .gray : Color("dark"))
            
            VStack {
                Text("Cupertion, CA")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                
                Image(systemName: isNight ? "moon.stars.fill" : "cloud.sun.fill")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 150)
                    .padding(.top, isSmall ? 40 : 0)
                
                Text("76º")
                    .font(.system(size: isSmall ? 70 : 50, weight: .semibold))
                    .foregroundColor(.white)
                
                VStack(spacing: isSmall ? 40 : 20) {
                    HStack(spacing: 16) {
                        ForEach(weathers) { item in
                            VStack(alignment: .center, spacing: 16, content: {
                                Text(item.dayOfWeek)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                                
                                Image(systemName: item.image)
                                    .resizable()
                                    .renderingMode(.original)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 35, height: 35)
                                
                                Text(item.temperature)
                                    .font(.system(size: 30, weight: .medium))
                                    .foregroundColor(.white)
                            })
                        }
                    }
                    
                    Button(action: {
                        isNight.toggle()
                    }, label: {
                        Text("Change Time Of Day")
                            .font(.system(size: 26, weight: .bold))
                            .frame(width: UIScreen.main.bounds.width - 50)
                            .padding(.vertical)
                    })
                    .background(Color.white)
                    .cornerRadius(14)
                }
                .padding(.top, isSmall ? 30 : 20)
            }
            
            Spacer()
        }
        .ignoresSafeArea(.all, edges: .all)
    }
}

struct Weather_Previews: PreviewProvider {
    static var previews: some View {
        Weather()
    }
}

struct GradientView: View {
    
    var topColor: Color
    var bottomColor: Color
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [topColor, bottomColor]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
