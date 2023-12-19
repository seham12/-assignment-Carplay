//
//  HomeView.swift
//  ArticlesApp
//


import SwiftUI

struct HomeView: View {
    @ObservedObject var articlesVM = ArticlesViewModel()
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
                    VStack{
                        Text("Today's Top 5 Articles")
                            .bold()
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .padding(.leading)
                        ScrollView(.horizontal,showsIndicators: false){
                            HStack(spacing: 20){
                                ForEach(articlesVM.Articles){ art in
                                    NavigationLink {
                                        ArticleDetials(image: art.image, title: art.title, article: art.article,author: art.author, dateOfPublish: art.dateOfPublish)
                                    } label: {
                                        AsyncImage(url: URL(string: art.image), content: { image in
                                            image.resizable()
                                                .cornerRadius(15)
                                                .frame(width: 200,height: 200)
                                            
                                            
                                        },
                                                   placeholder: {
                                            ProgressView()
                                        })  .cornerRadius(15)
                                            .frame(width: 200,height: 200)
                                    }
                                    
                                    
                                }
                                
                            }
                        }
                        .frame(maxWidth: .infinity,maxHeight: 200)
                        .padding(.leading)
                        
                        
                        
                        Text("Atricles")
                            .bold()
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .padding(.leading)
                            .padding(.vertical)
                        let shuffeluedArray = articlesVM.Articles.shuffled()
                        ForEach(shuffeluedArray){
                            art in
                            NavigationLink {
                                ArticleDetials(image: art.image, title: art.title, article: art.article,author: art.author, dateOfPublish: art.dateOfPublish)
                            } label: {
                                FavoriteArticlesComponenet(image: art.image, title: art.title, description: art.author)
                                    .frame(height: 100)
                                    .padding(.horizontal)
                            }.foregroundColor(.black)

                               
                  
                              
                            
                        }
                        
                        
                    }
                }
            }
        }
    }
}
#Preview {
    HomeView()
}
