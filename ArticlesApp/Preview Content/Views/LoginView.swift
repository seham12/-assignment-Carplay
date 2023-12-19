//
//  LoginView.swift
//  ArticlesApp
//
//  Created by ghada Mohammad on 02/06/1445 AH.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var usersVM = UsersViewModel()
    @AppStorage("email") var userEmail = ""
    @State var userPassword = ""
    @State var isLogin = false
    @State var showSignUp = false
   @State var errorMassage = ""
    var body: some View {
        NavigationStack{
            if isLogin{
                ContentView()
            }
            else if showSignUp{
                SignUpView()
            }else{
                
                
                
                VStack{
                    Spacer()
                    Text("Articley")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.purple2)
                    
                    Image("logo2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                    Spacer()
                    //            Text("Login")
                    //                .font(.title)
                    //                .bold()
                    //                .frame(width: 250)
                    //                .multilineTextAlignment(.center)
                    
                    TextField("Email", text: $userEmail)
                        .padding(.leading)
                        .frame(width: 300,height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke( LinearGradient(gradient: Gradient(colors: [.purple2,.purpulee, .orangee]), startPoint: .leading, endPoint: .trailing) , style: .init(lineWidth: 2.5))
                        )
                        .padding(.bottom)
                    
                    SecureField("Password", text: $userPassword)
                        .padding(.leading)
                        .frame(width: 300,height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke( LinearGradient(gradient: Gradient(colors: [.purpulee, .orangee,.purple2]), startPoint: .leading, endPoint: .trailing) , style: .init(lineWidth: 2.5))
                        )
                        .padding(.bottom)
                    
                    
                    Button(action: {
                        Task{
                    await isLogin = usersVM.authentication(password: userPassword ,email: userEmail)
                        }
                        if isLogin == false{
                            self.errorMassage = "Wrong email or password"
                        }
                        
                    }, label: {
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(.purple2)
                            .frame(width: 300,height: 50)
                            .overlay {
                                Text("Login")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                        
                    })
                    
                    Text(errorMassage)
                        .foregroundColor(.red)
                    
                    HStack{
                        Text("New to Articlaly ?")
                        NavigationLink {
                            SignUpView()
                        } label: {
                            Text("Create Account")
                        }
                        
                    }
                    
                    Spacer()
                    
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
