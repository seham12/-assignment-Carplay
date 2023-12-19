//
//  SearchView.swift
//  ArticlesApp




import SwiftUI

struct SearchView: View {
    @ObservedObject var articlesVM = ArticlesViewModel()
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    @State var searchValue = ""
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Text("Articley")
                        .font(.title)
                        .foregroundColor(.purple2)
                        .bold()
                    Spacer()
                    ZStack{
                        Image(systemName: "bell.fill")
                            .padding()
                            .background(.gray.opacity(0.3))
                            .clipShape(Circle())
                        Circle()
                            .fill(.red)
                            .frame(width: 12)
                            .offset(x: 17,y: -17)
                    }
                }.padding(.horizontal)
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now()){
                            Task{
                                await  articlesVM.fetch()
                            }
                        }
                        
                    }
                
                ScrollView{
                    Text("Exeplore Articles")
                        .font(.title3)
                        .bold()
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(.gray.opacity(0.1))
                        .frame(width: 300,height: 50)
                        .overlay {
                            HStack{
                                Image(systemName: "magnifyingglass")
                                TextField("Search articles here...", text: $searchValue)
                                //                                .padding(.leading)
                                    .frame(width: 300)
                            }.padding(.leading,50)
                        }
                    let searchArray = articlesVM.Articles.filter{$0.title.contains(searchValue)}
                    
                    if searchValue.isEmpty{
                        
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(articlesVM.Articles){ art in
                                NavigationLink {
                                    ArticleDetials(image: art.image, title: art.title, article: art.article, author: art.author, dateOfPublish: art.dateOfPublish)
                                       
                                } label: {
                                    SearchArticleCard(image: art.image, title: art.title, description: art.description)
                                }.foregroundColor(.black)
                                
                                
                                
                            }
                            
                        }
                        .padding(.top)
                    }else{
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(searchArray){ art in
                                
                                NavigationLink {
                                    ArticleDetials(image: art.image, title: art.title, article: art.article, author: art.author, dateOfPublish: art.dateOfPublish)
                                       
                                } label: {
                                    SearchArticleCard(image: art.image, title: art.title, description: art.description)
                                }.foregroundColor(.black)
                                
                            }
                            
                        }
                        .padding(.top)
                        
                    }
                    
                    
                    
                    
                }
            }
        }
    }
}
#Preview {
    SearchView()
}
