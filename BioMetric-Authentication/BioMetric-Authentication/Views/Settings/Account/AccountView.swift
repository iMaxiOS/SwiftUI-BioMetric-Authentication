//
//  AccountView.swift
//  BioMetric-Authentication
//
//  Created by Maxim Granchenko on 15.12.2020.
//

import SwiftUI

struct AccountView: View {
    
    private var colors = [Color.white, Color.pink]
    private var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    
    @State private var selected = 0
    @State private var workouts = [
        WorkoutModel(id: 0, day: "Day 1", workoutMin: 820),
        WorkoutModel(id: 1, day: "Day 2", workoutMin: 1080),
        WorkoutModel(id: 2, day: "Day 3", workoutMin: 350),
        WorkoutModel(id: 3, day: "Day 4", workoutMin: 870),
        WorkoutModel(id: 4, day: "Day 5", workoutMin: 1150),
        WorkoutModel(id: 5, day: "Day 6", workoutMin: 451),
        WorkoutModel(id: 6, day: "Day 7", workoutMin: 726),
    ]
    
    @State private var statsData = [
        Stats(id: 0, title: "Running", currentData: 6.8, goal: 15, color: Color("bg")),
        Stats(id: 1, title: "Water", currentData: 3.5, goal: 5, color: Color("p3")),
        Stats(id: 2, title: "Energy Burn", currentData: 585, goal: 1000, color: Color("green")),
        Stats(id: 3, title: "Sleep", currentData: 6.2, goal: 10, color: Color("lightBlue")),
        Stats(id: 4, title: "Cycling", currentData: 12.5, goal: 25, color: Color("p1")),
        Stats(id: 5, title: "Steps", currentData: 16889, goal: 20000, color: Color("dark")),
    ]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack {
                VStack {
                    VStack {
                        Image("1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 300)
                        
                        Text("Granchenko Maxim")
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundColor(.white)
                        
                        Text("iOS Developer")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .padding()
                    
                    HStack {
                        ForEach(workouts) { work in
                            VStack {
                                Spacer(minLength: 0)
                                
                                if selected == work.id {
                                    Text(getHrs(value: work.workoutMin))
                                        .foregroundColor(Color.white)
                                        .padding(.bottom, 5)
                                }
                                
                                RoundShape()
                                    .fill(LinearGradient(
                                            gradient: .init(colors: selected == work.id ? colors : [Color.black.opacity(0.2)]),
                                            startPoint: .top, endPoint: .bottom)
                                    )
                                    .cornerRadius(5)
                                    .frame(height: getHeight(value: work.workoutMin))
                                
                                Text(work.day)
                                    .foregroundColor(Color.white)
                            }
                            .frame(height: 220)
                            .onTapGesture {
                                selected = work.id
                            }
                        }
                    }
                    .frame(height: 150)
                    .padding()
                    
                    VStack {
                        Text("Statistic")
                            .font(.title)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        
                        LazyVGrid(columns: columns, spacing: 30) {
                            ForEach(statsData) { stat in
                                VStack(spacing: 20) {
                                    HStack {
                                        Text(stat.title)
                                            .font(.system(size: 22))
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                        
                                        Spacer(minLength: 0)
                                    }
                                    
                                    ZStack {
                                        Circle()
                                            .trim(from: 0.0, to: 1.0)
                                            .stroke(stat.color.opacity(0.05), lineWidth: 10)
                                            .frame(width: (UIScreen.main.bounds.width - 150) / 2, height: (UIScreen.main.bounds.width - 150) / 2)
                                        
                                        Circle()
                                            .trim(from: 0.0, to: (stat.currentData / stat.goal))
                                            .stroke(stat.color, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                                            .frame(width: (UIScreen.main.bounds.width - 150) / 2, height: (UIScreen.main.bounds.width - 150) / 2)
                                        
                                        Text(getPercent(current: stat.currentData, goal: stat.goal) + " %")
                                            .font(.system(size: 22))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color("bg"))
                                            .rotationEffect(.init(degrees: 90))
                                    }
                                    .rotationEffect(.init(degrees: -90))
                                    
                                    Text(getDec(value: stat.currentData) + getType(val: stat.title))
                                    .font(.system(size: 22))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("bg"))
                                }
                                .padding()
                                .background(Color.white.opacity(0.06))
                                .cornerRadius(15)
                                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0.0, y: 0.0)
                            }
                        }
                        .padding()
                    }
                    .padding(.top, 40)
                }
            }
        })
        .background(
            GradientView(topColor: Color("lightBlue").opacity(0.5), bottomColor: Color("lightBlue"))
        )
        .ignoresSafeArea(.all, edges: .all)
    }
    
    func getHeight(value: CGFloat) -> CGFloat {
        let hrs = CGFloat(value / 1440) * 200
        return hrs
    }
    
    func getDec(value: CGFloat) -> String {
        let format = NumberFormatter()
        format.numberStyle = .decimal
        
        return format.string(from: NSNumber.init(value: Float(value))) ?? ""
    }
    
    func getHrs(value: CGFloat)->String{
        let hrs = value / 60
        return String(format: "%.1f", hrs)
    }
    
    func getPercent(current: CGFloat, goal: CGFloat) -> String {
        let per = (current / goal) * 100
        return String(format: "%.1f", per)
    }
    
    func getType(val: String) -> String {
        switch val {
        case "Water":
            return "L"
        case "Sleep":
            return "Hrs"
        case "Running":
            return "Km"
        case "Cycling":
            return "Km"
        case "Steps":
            return "stp"
        default:
            return "Kcal"
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
