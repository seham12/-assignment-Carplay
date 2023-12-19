//
//  ContentView.swift
//  ArticlesApp
//
//
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab = 0
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        ZStack(alignment: .bottom){
                TabView(selection: $selectedTab) {
                    HomeView()
                        .tag(0)

                    SearchView()
                        .tag(1)

                    ProfileView()
                        .tag(2)
                   
                }
           
            ZStack{
                HStack{
                    ForEach((TabbedItems.allCases), id: \.self){ item in
                        Button{
                            selectedTab = item.rawValue
                        } label: {
                            CustomTabItem(imageName: item.iconName, title: item.title, isActive: (selectedTab == item.rawValue))
                        }
                    }
                }
                .padding(6)
            }
            .frame(height: 70)
            .background(.ultraThinMaterial)
            .cornerRadius(35)
            .padding(.horizontal, 26)
            }
        
     
    }
}

#Preview {
    ContentView()
}
extension ContentView{
    func CustomTabItem(imageName: String, title: String, isActive: Bool) -> some View{
        HStack(spacing: 10){
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? .black : .gray)
                .frame(width: 20, height: 20)
            if isActive{
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(isActive ? .black : .gray)
            }
            Spacer()
        }
        .frame(width: isActive ? .infinity : 60, height: 60)
        .background(isActive ? .purple2.opacity(0.4) : .clear)
        .cornerRadius(30)
    }
}
enum TabbedItems: Int, CaseIterable{
    case home = 0
    case favorite
    case profile
    
    var title: String{
        switch self {
        case .home:
            return "Home"
        case .favorite:
            return "Favorite"
        case .profile:
            return "Profile"
  
        }
    }
    
    var iconName: String{
        switch self {
        case .home:
            return "house.fill"
        case .favorite:
            return "safari.fill"
        case .profile:
            return "person.fill"
     
        }
    }
}
