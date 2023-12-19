//
//  SignUpView.swift
//  ArticlesApp
//
//  Created by ghada Mohammad on 02/06/1445 AH.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @ObservedObject var usersVM = UsersViewModel()
    @State var email = ""
    @State var password = ""
    @State var userName = ""
    @State var showAlert = false
    var body: some View {
        VStack{
            
            Spacer()
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
                                
                                Text("Login")
                                
                            }
                            .foregroundColor(.black)
                        })
                    }
                })

            Text("Articley")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.purple2)
            
            Image("logo2")
                .resizable()
                .scaledToFit()
                .frame(width: 150)
            Spacer()
            VStack{
                TextField("your Email", text: $email)
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.purpulee, .orangee]), startPoint: .leading, endPoint: .trailing))
                    .frame(height: 2)
                    .padding(.bottom,20)
                SecureField("your Password", text: $password)
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.purpulee, .orangee]), startPoint: .leading, endPoint: .trailing))
                    .frame(height: 2)
                   
                TextField("your Full Name", text: $userName)
                    .padding(.top,20)
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.purpulee, .orangee]), startPoint: .leading, endPoint: .trailing))
                    .frame(height: 2)
            }.frame(width: 300)
                .padding(.bottom,40)
            
            Button(action: {
                showAlert.toggle()
                Task{
                 await usersVM.creatAccount(name: userName, email: email, password: password)
                }
            }, label: {
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(.purple2)
                    .frame(width: 300,height: 50)
                    .overlay {
                        Text("SignUp")
                            .foregroundColor(.white)
                            .bold()
                    }
                
            })
            Spacer()
        } .alert(isPresented: $showAlert) {
            Alert(title: Text("You have signed up successfuly!"), message: Text("Go to login"), dismissButton: .default(Text("Got it!")))
        }    }
}

#Preview {
    SignUpView()
}
