//
//  ArticleDetials.swift
//  ArticlesApp
//
//  Created by ghada Mohammad on 03/06/1445 AH.
//

import SwiftUI

struct ArticleDetials: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @ObservedObject var articlesVM = ArticlesViewModel()
    @ObservedObject var vm = Audieo()
    @AppStorage("email") var userEmail = ""
    var email = "Example@email.com"
    @State var isPlay = false
    @State var isLiked = false
    var image:String
    var title:String
    var article:String
    var author:String
    var dateOfPublish:String
    
    var body: some View {
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
                .navigationBarBackButtonHidden(true)
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            HStack{
                                
                                Image(systemName: "chevron.left")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 10)
                                
                               
                                
                            }
                            .foregroundColor(.black)
                        })
                    }
                })
            
            ScrollView{
                AsyncImage(url: URL(string: image), content: { image in
                    image.resizable()
                        .cornerRadius(15)
                    .frame(width: 350,height: 350)
                   
                        
                },
                           placeholder: {
                    ProgressView()
                })   
                .cornerRadius(15)
                    .frame(width: 350,height: 350)
                    .padding(.bottom)
                HStack{
                    Rectangle()
                        .frame(height: 2)
                    
                    
                    Button {
                        isPlay.toggle()
                        if isPlay{
                            vm.fetchAudio(text: article)
                            
                        }else{
                            vm.stopAudio()
                        }
                    } label: {
                        Image(systemName: isPlay ? "pause.fill" : "play.fill")
                            .foregroundColor(.white)
                            .padding()
                            .background(.black)
                            .clipShape(Circle())
                        
                    }
                    Rectangle()
                        .frame(height: 2)

                }
                VStack(alignment: .leading){
                    HStack{
                        if isPlay && vm.audioPlayer == nil{
                            Text("Loading...")
                        }
                        if vm.audioPlayer != nil {
                            Text("Audio is playing...")
                            
                            
                        }
                        
                        Spacer()
                        Button {
                            isLiked.toggle()
                            Task{
                             await   articlesVM.addFavorite(userId: email, title: title, article: article, image: image, author: author, dateOfPublish: dateOfPublish)
                            }
                        } label: {
                            HStack{
                                Text("Add to favorite")
                                    .foregroundColor(.black)
                                Image(systemName: isLiked ? "heart.fill" : "heart")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30)
                                    .foregroundColor(isLiked ? .red : .black)
                                
                            }
                        }
                    }
                 
                        Text(title)
                            .font(.title)
                            .bold()
                        
                   

                       
                    
                    Text(article)
                    
                    
                    VStack(alignment: .leading){
                        Text("Author: \(author)")
                        Text("Date of publish: \(dateOfPublish)")
                    }
                    .padding(.top)
                    .foregroundColor(.gray)
                    .bold()
                    .frame(maxWidth: .infinity,alignment: .leading)
                      
                }.frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    ArticleDetials(image: "https://theprivatepracticeorg.files.wordpress.com/2023/04/person-meditating-outdoors-in-a-peaceful-setting-for-mindfulness-and-self-awareness.jpeg?w=1024" , title: "Title", article: "article", author: "author", dateOfPublish: "12/12")
}
