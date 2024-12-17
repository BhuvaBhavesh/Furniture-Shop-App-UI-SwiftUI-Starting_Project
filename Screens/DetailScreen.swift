//
//  DetailScreen.swift
//  Furniture_app
//
//  Created by GTCSYS Mac Mini 1  on 17/12/24.
//

import SwiftUI


struct DetailScreen: View {
    var body: some View {
        VStack {
            ZStack{
                Color("Bg")
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView{
                    Image("chair_1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .edgesIgnoringSafeArea(.top)
                    
                    DescriptionView()
                        .offset(y: -40)
                }
                HStack{
                    Text("$1299")
                        .font(.title)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: {}, label: {
                        Text("Add To Cart")
                            .padding()
                            .padding(.horizontal)
                            .background(Color.white)
                            .cornerRadius(10.0)
                            .foregroundColor(Color("Primary"))
                    })
                }
                .padding()
                .padding(.horizontal)
                .background(Color("Primary"))
                .cornerRadius(50, corners: .topLeft)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}


struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct DescriptionView: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("Luruxy Swedia \nChair")
                .font(.title)
                .fontWeight(.bold)
            
            HStack(spacing: 4){
                ForEach(0 ..< 5){
                    item in
                    Image("star")
                }
                Text("(4.9)")
                    .opacity(0.5)
                    .padding(.leading, 8)
                
                Spacer()
            }
            
            Text("Description")
                .fontWeight(.medium)
                .padding(.vertical, 8)
            
            Text("Experience the perfect blend of comfort and elegance with the Luxury Swedian Chair. Crafted with precision, this masterpiece is designed to elevate your living space while offering unmatched coziness.")
                .lineSpacing(8.0)
                .opacity(0.6)
            
            HStack(alignment: .top){
                VStack(alignment: .leading){
                    Text("Size")
                        .fontWeight(.semibold)
                        .padding(.bottom,4)
                    Text("Height: 120 cm")
                        .opacity(0.6)
                    Text("wide: 80 cm")
                        .opacity(0.6)
                    Text("Diameter: 72 cm")
                        .opacity(0.6)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading){
                    Text("Treatment")
                        .fontWeight(.semibold)
                        .padding(.bottom,4)
                    
                    Text("Jati wood, Canvas, \nAmazing Love")
                        .opacity(0.6)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical)
            
            HStack(alignment: .bottom){
                VStack(alignment: .leading){
                    Text("Colors")
                        .fontWeight(.semibold)
                    
                    HStack{
                        ColorDotView(color: .white)
                        ColorDotView(color: .black)
                        ColorDotView(color: Color("Primary"))
                    }
                }
                
                Spacer()
                VStack(alignment: .leading){
                    Text("Quantity")
                        .fontWeight(.semibold)
                    
                    HStack{
                        Button(action: {}){
                            Image(systemName: "minus")
                                .padding(.all,8)
                        }
                        .frame(width: 30, height: 30)
                        .overlay(RoundedRectangle(cornerRadius: 50).stroke())
                        
                        Text("1")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 8)
                        
                        Button(action: {}){
                            Image(systemName: "plus")
                                .padding(.all,8)
                        }
                        .background(Color("Primary"))
                        .clipShape(Circle())
                        .foregroundColor(.white)
                        
                    }
                    
                }
            }
                    
                }
                .padding()
                .padding(.top)
                .background(Color("Bg"))
                .cornerRadius(40.0)
            }
        }
            
        struct ColorDotView: View {
            let color: Color
            var body: some View {
                color
                    .frame(width: 24,height: 24)
                    .clipShape(Circle())
            }
        }
    


#Preview {
    DetailScreen()
}
