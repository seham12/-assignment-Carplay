//
//  SearchArticleCard.swift
//  ArticlesApp



import SwiftUI

struct SearchArticleCard: View {
    var image:String
    var title:String
    var description:String
    var body: some View {
        VStack(alignment: .leading){
            AsyncImage(url: URL(string: image), content: { image in
                image.resizable()
                   
                    .cornerRadius(15)
                .frame(width: 170,height: 170)
               
                    
            },
                       placeholder: {
                ProgressView()
            })
            .frame(width: 170,height: 170)
            .background(.gray.opacity(0.3))
            .cornerRadius(15)
            
            Text(title)
                .bold()
            Text(description)
                .font(.caption2)
                .foregroundColor(.gray)
                .lineLimit(3)
        }.frame(width: 150)
            .multilineTextAlignment(.leading)
    }
}

#Preview {
    SearchArticleCard(image: "https://theprivatepracticeorg.files.wordpress.com/2023/04/person-meditating-outdoors-in-a-peaceful-setting-for-mindfulness-and-self-awareness.jpeg?w=1024", title: "title", description: "description")
}
