//
//  FavoriteArticlesComponenet.swift
//  ArticlesApp
//
//  Created by ghada Mohammad on 02/06/1445 AH.
//

import SwiftUI

struct FavoriteArticlesComponenet: View {
    var image: String
    var title: String
    var description: String
    var body: some View {
        HStack{
          AsyncImage(url: URL(string: image), content: { image in
              image.resizable()
                
                  .cornerRadius(15)
              .frame(width: 100,height: 100)
             
                  
          },
                     placeholder: {
              ProgressView()
          })
          .frame(width: 100,height: 100)
          .background(.gray.opacity(0.3))
          .cornerRadius(15)
         
                
            VStack(alignment: .leading){
                Text(title)
                    .bold()
                Text(description)
                    .foregroundColor(.gray)
                    .font(.caption)
            }.padding(.leading,8)
                .multilineTextAlignment(.leading)
            Spacer()
            Image(systemName: "chevron.right")
        }
    }
}

#Preview {
    FavoriteArticlesComponenet(image: "https://theprivatepracticeorg.files.wordpress.com/2023/04/person-meditating-outdoors-in-a-peaceful-setting-for-mindfulness-and-self-awareness.jpeg?w=1024", title: "Art 1", description: "description")
}
