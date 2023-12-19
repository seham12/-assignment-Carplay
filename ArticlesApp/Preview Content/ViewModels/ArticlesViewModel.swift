//
//  ArticlesViewModel.swift
//  ArticlesApp



import Foundation
import SwiftUI

class ArticlesViewModel: ObservableObject{
    
    @Published var Articles: [ArticlesModel] = []
    @Published var favorite: [FavoriteModel] = []

    
//    init() async{
//        fetch()
//    }

    func fetch() async{
        let url = URL(string: "https://lkbduasnalblwcvdszoq.supabase.co/rest/v1/Articles?select=*"
        )!
        var request = URLRequest(url: url)
        request.setValue(" eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxrYmR1YXNuYWxibHdjdmRzem9xIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDE3NzU5MDEsImV4cCI6MjAxNzM1MTkwMX0.a60vJ2SqfPGP1ytTQOhb7vErIR5TG1o41RJlrGK9MnA", forHTTPHeaderField: "apikey")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxrYmR1YXNuYWxibHdjdmRzem9xIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDE3NzU5MDEsImV4cCI6MjAxNzM1MTkwMX0.a60vJ2SqfPGP1ytTQOhb7vErIR5TG1o41RJlrGK9MnA", forHTTPHeaderField: "Authorization")
        
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            if let data = data{
                print(String(data: data, encoding: .utf8)!)
                let decoder = JSONDecoder()
                do{
                    let jsonDecoder = try decoder.decode([ArticlesModel].self, from: data)
                    DispatchQueue.main.async {
                        self.Articles = jsonDecoder
                    }
                   
                }catch{
                    print(error)
                }
            }
            
            
            
        }
        
        task.resume()
        
    }
    
  
              
    func addFavorite(userId:String, title: String, article:String , image:String , author:String, dateOfPublish:String)async{
        let url = URL(string: "https://lkbduasnalblwcvdszoq.supabase.co/rest/v1/FavoriteArticles")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxrYmR1YXNuYWxibHdjdmRzem9xIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDE3NzU5MDEsImV4cCI6MjAxNzM1MTkwMX0.a60vJ2SqfPGP1ytTQOhb7vErIR5TG1o41RJlrGK9MnA", forHTTPHeaderField: "apikey")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxrYmR1YXNuYWxibHdjdmRzem9xIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDE3NzU5MDEsImV4cCI6MjAxNzM1MTkwMX0.a60vJ2SqfPGP1ytTQOhb7vErIR5TG1o41RJlrGK9MnA", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("return=minimal", forHTTPHeaderField: "Prefer")
        
        
        let jsonString = """
        {
           "userId": "\(userId)",
            "title": "\(title)",
            "article": "\(article)",
           "image": "\(image)",
            "author": "\(author)",
            "dateOfPublish": "\(dateOfPublish)"
        }
        """
        let jsonData = jsonString.data(using: .utf8)!
        request.httpBody = jsonData

        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error with fetching data: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error: Did not receive a valid HTTP response")
                return
            }

            if (200...299).contains(httpResponse.statusCode) {
                print("New row added successfully with status code: \(httpResponse.statusCode)")
            } else {
                print("Failed to add new row with status code: \(httpResponse.statusCode)")
            }
        }

        task.resume()
    }
              
    
    func getUsersFavorite(id:String) async{
        let url = URL(string: "https://lkbduasnalblwcvdszoq.supabase.co/rest/v1/FavoriteArticles?userId=eq.\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxrYmR1YXNuYWxibHdjdmRzem9xIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDE3NzU5MDEsImV4cCI6MjAxNzM1MTkwMX0.a60vJ2SqfPGP1ytTQOhb7vErIR5TG1o41RJlrGK9MnA", forHTTPHeaderField: "apikey")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxrYmR1YXNuYWxibHdjdmRzem9xIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDE3NzU5MDEsImV4cCI6MjAxNzM1MTkwMX0.a60vJ2SqfPGP1ytTQOhb7vErIR5TG1o41RJlrGK9MnA", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error with fetching data: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let decoded: [FavoriteModel] = try decoder.decode([FavoriteModel].self, from: data)
                    DispatchQueue.main.asyncAfter(deadline: .now()){
                        self.favorite = decoded
                    }
                    
                } catch {
                    print("error: \(error)")
                }
            } else {
                print("no data")
            }
        }
        
        task.resume()
    }

}
