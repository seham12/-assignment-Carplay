//
//  ProfileView.swift
//  ArticlesApp
//
//  Created by ghada Mohammad on 02/06/1445 AH.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("email") var userEmail = ""
    var email = "Example@email.com"
    @ObservedObject var usersVM = UsersViewModel()
    @ObservedObject var articlesVM = ArticlesViewModel()
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Text("Articley")
                        .font(.title2)
                        .foregroundColor(.purple2)
                        .bold()
                    Spacer()
                    Image(systemName: "gearshape.fill")
                        .padding(12)
                        .background(.gray.opacity(0.3))
                        .clipShape(Circle())
                }.padding(.horizontal)
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now()){
                            Task{
                                await usersVM.getUsersProfile(email: email)
                                await articlesVM.getUsersFavorite(id: email)
                                
                            }
                        }
                    }
                ScrollView{
                    ZStack{
                        Image("background")
                            .resizable()
                            .frame(width: 350,height: 230)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .overlay {
                                
                                VStack{
                                    ForEach(usersVM.userProfile){ info in
                                        Text("Hello, \(info.name)")
                                            .foregroundColor(.white)
                                            .font(.title2)
                                            .bold()
                                            .padding(.vertical)
                                    }
                                    
                                    Text("\(articlesVM.favorite.count)")
                                        .bold()
                                        .foregroundColor(.white)
                                    Text("Fivorate Articles")
                                        .foregroundColor(.white)
                                        .font(.callout)
                                    
                                }
                            }
                        Circle()
                            .fill(.white)
                            .frame(width: 150)
                            .offset(y: -120)
                            .overlay {
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 135)
                                    .offset(y: -120)
                            }
                    }.padding(.top,70)
                        .padding(.bottom)
                    
                    Text("Favorite Articles")
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.leading)
                        .font(.title2)
                        .bold()
                    
                    VStack{
                        ForEach(articlesVM.favorite){ art in
                            
                            NavigationLink {
                                ArticleDetials(image: art.image, title: art.title, article: art.article, author: art.author, dateOfPublish: art.dateOfPublish)
                            } label: {
                                FavoriteArticlesComponenet(image: art.image, title: art.title, description: art.author)
                            }.foregroundColor(.black)
                            
                            
                            
                        }
                    }.padding(.horizontal)
                    
                    Spacer()
                }
            }
        }
    }
}
#Preview {
    ProfileView()
}
