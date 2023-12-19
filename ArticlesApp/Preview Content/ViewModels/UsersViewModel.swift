//
//  UsersViewModel.swift
//  ArticlesApp
//
//  Created by ghada Mohammad on 02/06/1445 AH.
//

import Foundation

class UsersViewModel: ObservableObject{
    
    @Published var usersInfo:[UsersModel] = []
    @Published var userProfile: [UsersModel] = []
    
    func getUsersData() async{
        let url = URL(string: "https://lkbduasnalblwcvdszoq.supabase.co/rest/v1/Users?select=*'")!
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
                    let decoded: [UsersModel] = try decoder.decode([UsersModel].self, from: data)
                    DispatchQueue.main.async(){
                        self.usersInfo = decoded
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
    
    func getUsersProfile(email: String) async{
        let url = URL(string: "https://lkbduasnalblwcvdszoq.supabase.co/rest/v1/Users?email=eq.\(email)")!
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
                    let decoded: [UsersModel] = try decoder.decode([UsersModel].self, from: data)
                    DispatchQueue.main.async(){
                        self.userProfile = decoded
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
              
    func creatAccount( name:String, email:String, password:String)async{
        let url = URL(string: "https://lkbduasnalblwcvdszoq.supabase.co/rest/v1/Users")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxrYmR1YXNuYWxibHdjdmRzem9xIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDE3NzU5MDEsImV4cCI6MjAxNzM1MTkwMX0.a60vJ2SqfPGP1ytTQOhb7vErIR5TG1o41RJlrGK9MnA", forHTTPHeaderField: "apikey")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxrYmR1YXNuYWxibHdjdmRzem9xIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDE3NzU5MDEsImV4cCI6MjAxNzM1MTkwMX0.a60vJ2SqfPGP1ytTQOhb7vErIR5TG1o41RJlrGK9MnA", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("return=minimal", forHTTPHeaderField: "Prefer")
        
        
        let jsonString = """
        {
        "email": "\(email)",
        "name": "\(name)" ,
        "password": "\(password)"
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
    
    func authentication(password: String, email: String) async -> Bool {
        Task{
         await   getUsersData()
        }
        for i in usersInfo {
            if  email == i.email && password == i.password {
                return true
            }
        }
        return false
    }
    
}
