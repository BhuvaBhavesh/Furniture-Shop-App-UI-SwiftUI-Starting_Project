//
//  HomeScreen.swift
//  Furniture_app
//
//  Created by GTCSYS Mac Mini 1  on 17/12/24.
//

import SwiftUI

struct HomeScreen: View {
    @State private var selectedIndex: Int = 0
    private let categories = ["All", "Chair", "Sofa", "Lamp", "Kitchen", "Table"]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Bg")
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        AppBarView()
                        TagLineView()
                        SearchAndScanView()
                        
                        // Categories Section
                        categoryScrollView
                        
                        // Popular Section
                        productSection(title: "Popular", itemCount: 4, prefix: "chair")
                        
                        // Recommended Section
                        productSection(title: "Recommended", itemCount: 4, prefix: "chair")
                    }
                }
                
                HStack {
                    BottomNavBarItem(image: Image("Home")) {}
                    BottomNavBarItem(image: Image("fav")) {}
                    BottomNavBarItem(image: Image("shop")) {}
                    BottomNavBarItem(image: Image("User")) {}
                }
                .padding()
                .background(Color.white)
                .clipShape(Capsule())
                .padding(.horizontal)
                .shadow(color: Color.black.opacity(0.15), radius: 8, x: 2, y: 6)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
    }
    
    
    
    
    struct AppBarView: View {
        var body: some View {
            HStack {
                Button(action: {}) {
                    Image("menu")
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10.0)
                }
                Spacer()
                Button(action: {}) {
                    Image("Profile")
                        .resizable()
                        .frame(width: 42, height: 42)
                        .cornerRadius(10.0)
                }
            }
            .padding(.horizontal)
        }
    }
    
    struct TagLineView: View {
        var body: some View {
            Text("Find The \nBest")
                .font(.custom("PlayfairDisplay-Regular", size: 28))
                .foregroundColor(Color("Primary"))
            Text("Furniture!")
                .font(.custom("PlayfairDisplay-Bold", size: 28))
                .foregroundColor(Color("Primary"))
        }
    }
    
    struct SearchAndScanView: View {
        @State private var search: String = ""
        var body: some View {
            HStack {
                HStack {
                    Image("Search")
                        .padding(.trailing, 8)
                    TextField("Search Furniture", text: $search)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10.0)
                .padding(.trailing)
                
                Button(action: {}) {
                    Image("Scan")
                        .padding()
                        .background(Color("Primary"))
                        .cornerRadius(10.0)
                }
            }
            .padding(.horizontal)
        }
    }
    
    struct CategoryView: View {
        let isActive: Bool
        let text: String
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text(text)
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                    .foregroundColor(isActive ? Color("Primary") : Color.black.opacity(0.5))
                if isActive {
                    Color("Primary")
                        .frame(width: 15, height: 2)
                        .clipShape(Capsule())
                }
            }
            .padding(.trailing)
        }
    }
    
    struct ProductCardView: View {
        let image: Image
        let size: CGFloat
        var body: some View {
            VStack {
                image
                    .resizable()
                    .frame(width: size, height: 200 * (size / 210))
                    .cornerRadius(20.0)
                
                Text("Luxury Swedian chair")
                    .font(.title3)
                    .fontWeight(.bold)
                
                HStack(spacing: 2) {
                    ForEach(0 ..< 5) { _ in
                        Image("star")
                    }
                    Spacer()
                    Text("$1299")
                        .font(.title3)
                        .fontWeight(.bold)
                }
            }
            .frame(width: size)
            .padding()
            .background(Color.white)
            .cornerRadius(20.0)
        }
    }
    
    struct BottomNavBarItem: View {
        let image: Image
        let action: () -> Void
        var body: some View {
            Button(action: action) {
                image
                    .resizable() // Makes the image resizable
                    .frame(width: 24, height: 24) // Set the desired size for the icons
                    .frame(maxWidth: .infinity) // Ensures even spacing
            }
            
        }
    }
    
    private var categoryScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(categories.indices, id: \.self) { i in
                    CategoryView(isActive: i == selectedIndex, text: categories[i])
                        .onTapGesture {
                            selectedIndex = i
                        }
                }
            }
            .padding()
        }
    }
    private func productSection(title: String, itemCount: Int, prefix: String) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.custom("PlayfairDisplay-Bold", size: 24))
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0 ..< itemCount) { index in
                        NavigationLink(
                            destination: DetailScreen(), // Corrected `destination` spelling
                            label: {
                                ProductCardView(image: Image("\(prefix)_\(index + 1)"), size: 210)
                            }
                        )
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    
    struct HomeScreen_Previews: PreviewProvider {
        static var previews: some View {
            HomeScreen()
        }
    }
}
